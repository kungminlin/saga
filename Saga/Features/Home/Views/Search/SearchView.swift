import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var searchText: String
    @State private var viewModel = JournalViewModel()
    @State private var selectedFilter: SearchFilter = .all
    
    var filteredEntries: [JournalEntry] {
        let entries = viewModel.entries.filter { entry in
            if searchText.isEmpty { return true }
            return entry.title.localizedCaseInsensitiveContains(searchText) ||
                   entry.body.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectedFilter {
        case .all:
            return entries
        case .today:
            return entries.filter { Calendar.current.isDateInToday($0.created_at ?? Date()) }
        case .week:
            return entries.filter { Calendar.current.isDate($0.created_at ?? Date(), equalTo: Date(), toGranularity: .weekOfYear) }
        case .month:
            return entries.filter { Calendar.current.isDate($0.created_at ?? Date(), equalTo: Date(), toGranularity: .month) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(searchText: $searchText)
                FilterPillsView(selectedFilter: $selectedFilter)
                SearchResultsView(entries: filteredEntries)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchJournalEntries()
        }
    }
}

#Preview {
    SearchView(searchText: .constant(""))
} 