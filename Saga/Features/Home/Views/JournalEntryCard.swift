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
            Text(entry.title)
                .font(.title2)
                .bold()
                .background(.red)
            
            Text(entry.body)
                .lineLimit(2)
                .font(.body)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.quinary)
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    JournalEntryCard(entry: JournalEntry(
        id: 1,
        author: UUID(),
        title: "Title",
        body: "Body",
        created_at: nil,
        updated_at: nil
    ))
}
