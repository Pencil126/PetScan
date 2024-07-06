//
//  DetectViewModel.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/7/4.
//

import SwiftUI
import Vision
import CoreML

class DetectViewModel: ObservableObject {
    var model: VNCoreMLModel? = {
            do {
                // 请确保这里的模型名称与您的文件名一致
                let config = MLModelConfiguration()
                return try VNCoreMLModel(for: PetScanDogAugmentation(configuration: config).model)
            } catch {
                print("Failed to load the model: \(error)")
                return nil
            }
        }()
    
}
