//
//  JournalEntries.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/2/25.
//

import SwiftUI

struct JournalEntries: View {
    let viewModel: JournalViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if viewModel.entries.isEmpty {
                EmptyStateView()
            } else {
                ForEach(viewModel.entries) { entry in
                    ZStack {
                        JournalEntryCard(entry: entry)
                        NavigationLink(destination: JournalEntryView(entry: entry)) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(.horizontal)
        .refreshable {
            viewModel.fetchJournalEntries()
        }
        .onAppear {
            viewModel.fetchJournalEntries()
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)
            
            VStack(spacing: 8) {
                Text("No Entries Yet")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Start your journaling journey by creating your first entry")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            Button {
                // This will be handled by the parent view
            } label: {
                Label("Create Entry", systemImage: "plus")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.top, 8)
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
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
    ScrollView {
        VStack {
            JournalEntries(viewModel: JournalViewModel())
        }
    }
}
