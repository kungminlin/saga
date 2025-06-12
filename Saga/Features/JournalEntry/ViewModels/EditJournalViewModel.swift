//
//  JournalViewModel.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/22/25.
//

import Foundation

extension JournalEntryView {
    @Observable class ViewModel {
        private let entry: JournalEntry?
        
        var title: String
        var body: String
        
        init(entry: JournalEntry?) {
            guard let entry else {
                self.entry = nil
                self.title = ""
                self.body = ""
                return
            }
            
            self.entry = entry
            self.title = entry.title
            self.body = entry.body
        }
        
        func save() {
            Task {
                do {
                    // Create new entry
                    guard let entry else {
                        try await supabase.from("journal_entries").insert(
                            JournalEntry(
                                id: nil,
                                author: AuthManager.shared.session!.user.id,
                                title: title,
                                body: body,
                                created_at: nil,
                                updated_at: nil
                            )
                        ).execute()
                        
                        return
                    }
                    
                    // The journal entry is dirty
                    if entry.title != title || entry.body != body {
                        try await supabase.from("journal_entries")
                            .update([
                                "title": title,
                                "body": body
                            ])
                            .eq("author", value: AuthManager.shared.session!.user.id)
                            .eq("id", value: entry.id)
                            .execute()
                    }
                } catch let error {
                    print(error)
                }
            }
            
        }
    }
}
