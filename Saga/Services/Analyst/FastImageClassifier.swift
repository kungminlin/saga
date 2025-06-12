//
//  FastImageClassifier.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import Vision
import UIKit

class FastImageClassifier: Analyst {
    private static let classifier = createClassifier()
    
    private static func createClassifier() -> FastViTT8F16 {
        guard let classifier = try? FastViTT8F16(configuration: .init()) else {
            fatalError("App failed to create a FastViTT8F16 instance.")
        }
        
        return classifier
    }

    func analyze(_ image: UIImage) -> [String: Float] {
        guard let result = try? FastImageClassifier.classifier.prediction(image: image.resize(CGSize(width: 256, height: 256)).convertToBuffer()) else { return [:] }
        return result.classLabel_probs.mapValues { Float($0) }
    }
}
