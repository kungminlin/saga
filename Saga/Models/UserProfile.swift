//
//  User.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/27/25.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: UUID
    let handle: String
    let display_name: String
    let profile_image_url: String?
    let bio: String?
    let created_at: Date?
}
