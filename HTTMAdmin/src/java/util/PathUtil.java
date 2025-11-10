/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

/**
 *
 * @author namv2
 */
public class PathUtil {
    static String projectPath = "D:/School/MonHoc/PTC HTTM/PTIT-HTTM-Violence-Detection/HTTMAdmin";
    
    public static String getProjectPath(){
        return projectPath;
    }
    
    public static String getModelFileName(String modelName){
        String normalized = modelName.toLowerCase();
        // Thay mọi ký tự không phải a-z, 0-9 bằng "_"
        normalized = normalized.replaceAll("[^a-z0-9]+", "_");
        // Bỏ "_" dư ở đầu và cuối
        normalized = normalized.replaceAll("^_+|_+$", "");

        return normalized + ".pth";
    }
}
