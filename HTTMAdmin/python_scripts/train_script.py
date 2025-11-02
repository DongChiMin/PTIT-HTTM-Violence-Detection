import os
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
from torch.utils.data import Dataset, DataLoader
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
from collections import Counter
import torchvision.models.video as models
import sys
import json
import cv2 
import re
from load_folder import load_video_paths_from_folder

# ----- 1. Lớp Dataset -----
class ViolenceDataset(Dataset):
    def __init__(self, violence_paths, non_violence_paths, transform=None, num_frames=16):
        self.transform = transform
        self.samples = []
        self.num_frames = num_frames
        self.label2id = {"non_violence": 0, "violence": 1}
        
        # Lấy đường dẫn chính xác từ đường dẫn tương đối dạng data/train_samples/non_violence/okA8k7rF_0.avi
        current_dir = os.path.dirname(os.path.abspath(__file__))
        project_root = os.path.abspath(os.path.join(current_dir, ".."))
        violence_paths = [os.path.join(project_root, p) for p in violence_paths]
        non_violence_paths = [os.path.join(project_root, p) for p in non_violence_paths]

        # Gộp dữ liệu
        for p in non_violence_paths:
            if os.path.exists(p):
                self.samples.append((p, self.label2id["violence"]))  # 0 = non-violence
            else:
                print(f" Missing non-violence file: {p}", flush=True)

        for p in violence_paths:
            if os.path.exists(p):
                self.samples.append((p, self.label2id["non_violence"]))  # 1 = violence
            else:
                print(f" Missing violence file: {p}", flush=True)

        print(f"Loaded {len(self.samples)} total samples", flush=True)

    def __len__(self):
        return len(self.samples)

    def __getitem__(self, idx):
        clip_path, label = self.samples[idx]
        clip = load_clip_from_avi(clip_path, num_frames=self.num_frames)
        clip = np.transpose(clip, (3, 0, 1, 2))  # (C, T, H, W)
        return torch.tensor(clip), torch.tensor(label)


# ----- 2. Cắt video thành frame npy -----
def load_clip_from_avi(path, num_frames=16, resize=(112,112)):
    cap = cv2.VideoCapture(path)
    frames = []

    while len(frames) < num_frames:
        ret, frame = cap.read()
        if not ret:
            break
        frame = cv2.resize(frame, resize)
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        frames.append(frame)

    cap.release()

    # Nếu video ngắn hơn num_frames → lặp lại frame cuối
    while len(frames) < num_frames:
        frames.append(frames[-1])

    clip = np.stack(frames, axis=0)  # (T, H, W, C)
    return clip.astype(np.float32) / 255.0

# ----- 3. Chuẩn hóa tên model để lưu file-----
def normalize_model_name(name: str) -> str:
    # Lowercase
    name = name.lower()
    # Thay mọi ký tự không phải a-z, 0-9 thành "_"
    name = re.sub(r'[^a-z0-9]+', '_', name)
    # Bỏ "_" dư ở đầu và cuối
    name = name.strip('_')
    return name

# ----- 4. Hàm huấn luyện -----
def train():
    #đọc dữ liệu được gửi từ json
    config_path = sys.argv[1] 
    with open(config_path, 'r', encoding='utf-8') as f:
        config = json.load(f)

    model_name = config["modelName"]
    violence_paths = config["violenceSamplePaths"]
    non_violence_paths = config["nonViolenceSamplePaths"]
    print(f"Received {len(violence_paths)} violence and {len(non_violence_paths)} non-violence samples", flush=True)

    # # Dataset & DataLoader
    train_dataset = ViolenceDataset(violence_paths, non_violence_paths)
    train_loader = DataLoader(train_dataset, batch_size=64, shuffle=True)

    # Model: R3D-18 pre-trained
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = models.r3d_18(weights="DEFAULT")   # tải pre-trained trên Kinetics-400
    model.fc = nn.Linear(model.fc.in_features, 2)  # đổi output thành 2 lớp
    model = model.to(device)
    print("Using device:", device, flush=True)

    # Loss & Optimizer
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=1e-4)

    # Training loop
    EPOCHS = 10
    for epoch in range(EPOCHS):
        model.train()
        running_loss, correct, total = 0, 0, 0

        for batch_idx, (clips, labels) in enumerate(train_loader, 1):
            clips, labels = clips.to(device), labels.to(device)

            optimizer.zero_grad()
            outputs = model(clips)
            loss = criterion(outputs, labels)
            loss.backward()
            optimizer.step()

            running_loss += loss.item()
            _, predicted = torch.max(outputs, 1)
            correct += (predicted == labels).sum().item()
            total += labels.size(0)

        print(f"Epoch {epoch+1}/{EPOCHS} | Loss: {running_loss/len(train_loader):.4f} | Acc: {correct/total:.4f}", flush=True)

    # Lấy đường dẫn folder model
    current_dir = os.path.dirname(os.path.abspath(__file__))
    save_dir = os.path.join(current_dir, "..", "data", "model")
    os.makedirs(save_dir, exist_ok=True)

    # Save model
    output_path = os.path.join(save_dir, f"{normalize_model_name(model_name)}.pth")
    torch.save(model.state_dict(), output_path)
    print(f"Saved model {model_name} at {save_dir}", flush=True)
    return os.path.join(save_dir, f"{normalize_model_name(model_name)}.pth")

# ----- 5. Hàm test -----

def test(model_path, num_frames=16):
    current_dir = os.path.dirname(os.path.abspath(__file__))
    violence_dir = os.path.join(current_dir, "..", "data", "test_samples", "violence")
    non_violence_dir = os.path.join(current_dir, "..", "data", "test_samples", "non_violence")
    # Load dataset
    violence_paths, non_violence_paths = load_video_paths_from_folder(violence_dir, non_violence_dir)
    dataset = ViolenceDataset(violence_paths, non_violence_paths, num_frames=num_frames)
    loader = DataLoader(dataset, batch_size=16, shuffle=False)

    # Load model
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    model = models.r3d_18(weights=None)  # không cần pre-trained khi load weights đã train
    model.fc = nn.Linear(model.fc.in_features, 2)
    state_dict = torch.load(model_path, map_location=device, weights_only=True)
    model.load_state_dict(state_dict)
    model.to(device)
    model.eval()

    y_true = []
    y_pred = []

    with torch.no_grad():
        for clips, labels in loader:
            clips, labels = clips.to(device), labels.to(device)
            outputs = model(clips)
            _, predicted = torch.max(outputs, 1)
            y_true.extend(labels.cpu().numpy())
            y_pred.extend(predicted.cpu().numpy())

    # Tính metrics cho từng lớp
    labels_map = {0: "Non_Violence", 1: "Violence"}
    support_counts = Counter(y_true)
    metrics = []

    for class_id, class_name in labels_map.items():
        class_true = [1 if y == class_id else 0 for y in y_true]
        class_pred = [1 if y == class_id else 0 for y in y_pred]

        metrics.append({
            "label": class_name,
            "accuracy": round(accuracy_score(class_true, class_pred), 4),
            "precision": round(precision_score(class_true, class_pred, zero_division=0), 4),
            "recall": round(recall_score(class_true, class_pred, zero_division=0), 4),
            "f1_score": round(f1_score(class_true, class_pred, zero_division=0), 4),
            "support": support_counts[class_id]
        })

    # Tổng accuracy (all classes)
    total_acc = round(accuracy_score(y_true, y_pred), 4)

    result = {
        "total_accuracy": total_acc,
        "classes": metrics
    }

    # In ra JSON để Java đọc
    print("===JSON_RESULT_START===")
    print(json.dumps(result), flush=True)
    print("===JSON_RESULT_END===")
    return result

if __name__ == "__main__":
    model_dir = train()
    test(model_dir)
    print("DONE", flush=True)