//
//  JournalRow.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import SwiftUI

struct JournalRow: View {
    var entry: JournalEntry
    
    var body: some View {
        HStack {
            Text(entry.title)
                .font(.headline)
            Spacer()
        }
    }
}
