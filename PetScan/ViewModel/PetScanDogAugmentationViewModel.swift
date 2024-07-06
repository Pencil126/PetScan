//
//  PetScanDogAugmentationViewModel.swift
//  PetScan
//
//  Created by 廖清筆 on 2024/7/7.
//

import Foundation
import SwiftUI
import Vision
import CoreML

class PetScanDogAugmentationViewModel: ObservableObject {
    @Published var predictionResult: String = ""
    @Published var predictionProbabilities: [String: Double] = [:]
    
    private var model: PetScanDogAugmentation?
    
    init() {
        do {
            self.model = try PetScanDogAugmentation(configuration: .init())
        } catch {
            print("Failed to load the model: \(error.localizedDescription)")
        }
    }
    
    func predict(image: CGImage) {
        guard let model = self.model else {
            print("Model not available")
            return
        }
        
        do {
            let input = try PetScanDogAugmentationInput(imageWith: image)
            print("Predicting for image: \(image)")
            let output = try model.prediction(input: input)
            DispatchQueue.main.async {
                self.predictionResult = output.target
                self.predictionProbabilities = output.targetProbability
                print("Prediction result: \(output.target)")
                print("Prediction probabilities: \(output.targetProbability)")
            }
        } catch {
            print("Prediction error: \(error.localizedDescription)")
        }
    }
}
