//
//  SaliencyAnalyzer.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/20/25.
//

import Vision
import VisionKit

class SaliencyAnalyzer: Analyst {
    func analyze(_ image: UIImage) -> [String: Float] {
        let request = VNGenerateObjectnessBasedSaliencyImageRequest()
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        try? handler.perform([request])
        guard let results = request.results else { return [:] }
        return Dictionary(uniqueKeysWithValues: results.map { ($0.description, $0.confidence.magnitude) })
    }
}
