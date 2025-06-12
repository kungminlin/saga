//
//  MediaCatalogEntry.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/23/25.
//

import Photos
import Foundation

public struct MediaCatalogEntry: Identifiable {
    public let id: String
    public let timestamp: Date
    public let location: CLLocation?
    public let observations: [String: Float]
    
    public init(id: String, timestamp: Date, location: CLLocation?, observations: [String: Float]) {
        self.id = id
        self.timestamp = timestamp
        self.location = location
        self.observations = observations
    }
}

extension MediaCatalogEntry {
    public var label: String { return self.observations.keys.joined() }
}
