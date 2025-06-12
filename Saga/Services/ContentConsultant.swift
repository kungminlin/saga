//
//  MediaConsultant.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/24/25.
//

import os
import Photos
import UIKit

// TODO: Create interface and generalize `Consultant` concept
class ContentConsultant {
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: ContentConsultant.self)
    )
    
    private let catalog = MediaCatalogManager.shared
    
    private func query(query: String) async -> String? {
        guard let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyDf2a4HsYqgr6MzmwYHFcSQ3SAyLYT8P7M") else { return nil }
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let data = try? JSONEncoder().encode("{\"contents\":[{\"role\":\"user\",\"parts\":[{\"text\":\"\(query)\"}]}],\"generationConfig\":{\"temperature\":1,\"topK\":40,\"topP\":0.95,\"maxOutputTokens\":8192,\"responseMimeType\":\"text/plain\"}}") else { return nil }
        
        if let response = try? await URLSession.shared.upload(for: request, from: data) {
            print("response", response)
            return nil
        }
        
        return nil
    }
}
