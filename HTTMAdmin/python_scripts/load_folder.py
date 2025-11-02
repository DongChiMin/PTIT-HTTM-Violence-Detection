# dataset_loader.py
import os

def load_video_paths_from_folder(violence_dir, non_violence_dir, extensions=('.avi', '.mp4', '.mov')):
    violence_paths = []
    non_violence_paths = []

    # Lấy đường dẫn tuyệt đối
    violence_dir = os.path.abspath(violence_dir)
    non_violence_dir = os.path.abspath(non_violence_dir)

    # Duyệt qua folder bạo lực
    if os.path.exists(violence_dir):
        for file in os.listdir(violence_dir):
            if file.lower().endswith(extensions):
                violence_paths.append(os.path.join(violence_dir, file))
    else:
        print(f"Folder test not exist: {violence_dir}", flush=True)

    # Duyệt qua folder không bạo lực
    if os.path.exists(non_violence_dir):
        for file in os.listdir(non_violence_dir):
            if file.lower().endswith(extensions):
                non_violence_paths.append(os.path.join(non_violence_dir, file))
    else:
        print(f"Folder test not exist: {non_violence_dir}", flush=True)

    print(f"Loaded {len(violence_paths)} violence video test and {len(non_violence_paths)} non-violence video test.", flush=True)
    return violence_paths, non_violence_paths


if __name__ == "__main__":
    violence_dir = "../data/test_samples/violence"
    non_violence_dir = "../data/test_samples/non_violence"

    v_paths, nv_paths = load_video_paths_from_folder(violence_dir, non_violence_dir)
