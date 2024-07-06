//
//  DetectViewModel.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/7/4.
//

import SwiftUI
import Vision
import CoreML

class DetectPetScanDog: ObservableObject {
//    var model: VNCoreMLModel? = {
//        do {
//            // 请确保这里的模型名称与您的文件名一致
//            let config = MLModelConfiguration()
//            return try VNCoreMLModel(for: PetScanDogAugmentation(configuration: config).model)
//        } catch {
//            print("Failed to load the model: \(error)")
//            return nil
//        }
//    }()
    @Published var classification: String = ""

    func classifyImage(_ image: UIImage) {
        guard let model = try? VNCoreMLModel(for: PetScanDogAugmentation().model) else {
            fatalError("Failed to load model")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results as? [VNClassificationObservation] {
                let topResult = results.first
                DispatchQueue.main.async {
                    self.classification = topResult?.identifier ?? "Unknown"
                }
            } else {
                DispatchQueue.main.async {
                    self.classification = "ErrorRequest: \(error?.localizedDescription ?? "unknown error")"
                }
            }
        }

        DispatchQueue.global(qos: .userInitiated).async {
            guard let ciImage = CIImage(image: image) else {
                DispatchQueue.main.async {
                    self.classification = "Failed to convert UIImage to CIImage"
                }
                return
            }

            let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    self.classification = "ErrorHandler: \(error.localizedDescription)"
                }
            }
        }
    }
}
