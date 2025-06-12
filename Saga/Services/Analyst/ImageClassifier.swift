//
//  ImageClassifier.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import Photos
import Vision
import SwiftUI

class ImageClassifier : Analyst {
    @MainActor
    func analyze(_ image: UIImage) async throws -> [String: Float] {
        // Vision request to classify an image.
        let request = ClassifyImageRequest()
        
        // Convert SwiftUI Image to CGImage
        let renderer = ImageRenderer(content: Image(uiImage: image))
        renderer.scale = 1.0
        guard let cgImage = renderer.cgImage else { return [:] }
        
        // Perform the request on the image, and return an array of `ClassificationObservation` objects.
        let results = try await request.perform(on: cgImage)
            .filter {
                // Higher recall = Fewer false negatives
                $0.hasMinimumPrecision(0.1, forRecall: 0.8)
                
                // Higher precision = Fewer false positives
                && $0.hasMinimumRecall(0.01, forPrecision: 0.6)
                
                // High confidence
                && $0.confidence > 0.6
            }
            .sorted(by: { $0.confidence > $1.confidence })
        
        return Dictionary(uniqueKeysWithValues: results.map { ($0.identifier, $0.confidence) })
    }
}
