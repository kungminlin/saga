import SwiftUI

struct SearchResultsView: View {
    let entries: [JournalEntry]
    
    var body: some View {
        if entries.isEmpty {
            ContentUnavailableView {
                Label("No Results", systemImage: "magnifyingglass")
            } description: {
                Text("Try adjusting your search or filters")
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(entries) { entry in
                        NavigationLink(destination: JournalEntryView(entry: entry)) {
                            JournalEntryCard(entry: entry)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    SearchResultsView(entries: [
        JournalEntry(
            id: 1,
            author: UUID(),
            title: "Sample Entry",
            body: "This is a sample journal entry",
            created_at: Date(),
            updated_at: nil
        )
    ])
} 