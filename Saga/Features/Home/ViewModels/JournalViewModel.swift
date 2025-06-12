//
//  JournalViewModel.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/2/25.
//

import Foundation

@Observable class JournalViewModel {
    var entries = [JournalEntry]()
    
    func fetchJournalEntries() {
        Task {
            do {
                entries = try await supabase.from("journal_entries")
                    .select()
                    .order("updated_at", ascending: false)
                    .execute()
                    .value
                print("done fetching entries", entries)
            } catch let error {
                print(error)
            }
        }
    }
    
    func deleteEntry(_ id: Int) {
        Task {
            do {
                try await supabase.from("journal_entries").delete().eq("author", value: AuthManager.shared.session!.user.id).eq("id", value: id).execute()
            } catch let error {
                print(error)
            }
        }
    }
}
