//
//  Journal.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import Foundation

struct JournalEntry: Codable, Identifiable {
    let id: Int?
    let author: UUID
    let title: String
    let body: String
    let created_at: Date?
    let updated_at: Date?
}
