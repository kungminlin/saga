//
//  JournalEntryCard.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/3/25.
//

import SwiftUI

struct JournalEntryCard: View {
    let entry: JournalEntry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(entry.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    if let date = entry.created_at {
                        Text(date.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Text(entry.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

#Preview {
    JournalEntryCard(entry: JournalEntry(
        id: 1,
        author: UUID(),
        title: "A Beautiful Day",
        body: "Today was filled with joy and wonder. The sun was shining brightly, and I felt grateful for all the little moments that made this day special.",
        created_at: Date(),
        updated_at: nil
    ))
    .padding()
}
