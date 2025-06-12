//
//  JournalEntries.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/2/25.
//

import SwiftUI

struct JournalEntries: View {
    @State private var viewModel = JournalViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.entries) { entry in
                ZStack {
                    JournalEntryCard(entry: entry)
                    NavigationLink(destination: JournalEntryView(entry: entry)) {
                        EmptyView()
                    }.buttonStyle(PlainButtonStyle())
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .listRowSpacing(12)
        .refreshable {
            viewModel.fetchJournalEntries()
        }
        
        .onAppear {
            viewModel.fetchJournalEntries()
        }
    }
}

struct JournalEntryPreview: View {
    var body: some View {
        List {
            JournalEntryCard(entry: JournalEntry(
                id: 1,
                author: UUID(),
                title: "Title",
                body: "Body",
                created_at: nil,
                updated_at: nil
            ))
                .listStyle(PlainListStyle())
                .listRowBackground(Color.clear)
            
            JournalEntryCard(entry: JournalEntry(
                id: 2,
                author: UUID(),
                title: "Title",
                body: "Body",
                created_at: nil,
                updated_at: nil
            ))
                .listStyle(PlainListStyle())
                .listRowBackground(Color.clear)
        }
        .listRowSpacing(12)
    }
}

#Preview {
    JournalEntryPreview()
}
