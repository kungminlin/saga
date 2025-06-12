//
//  MediaCatalogManager.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import os
import Photos
import SwiftUI
import CoreLocation

let IMAGE_STORAGE_LIMIT = 200

public class MediaCatalogManager {
    public static let shared = MediaCatalogManager()
    private static let analyst: Analyst = ImageClassifier()
    
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: MediaCatalogManager.self)
    )
    
    private var catalog = [MediaCatalogEntry]()
    
    public func analyze() {
        let options = PHFetchOptions()
        
        options.fetchLimit = IMAGE_STORAGE_LIMIT
        
        let assets = PHAsset.fetchAssets(with: .image, options: options)
        
        Task(priority: .background) {
            logger.debug("Start making observations")
            await withTaskGroup(of: Void.self) { group in
                for asset in assets.objects(at: IndexSet(0..<assets.count)) {
                    group.addTask {
                        // TODO: Tag images and store them as catalog entry
                        let observations = try? await MediaCatalogManager.analyst.analyze(asset.thumbnail)
                    }
                }
            }
            logger.debug("Done making observations for \(IMAGE_STORAGE_LIMIT) images")
        }
    }
}
