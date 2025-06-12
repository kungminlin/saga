//
//  JournalView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import SwiftUI
import VisionKit

struct JournalEntryView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    private var entry: JournalEntry?
    
    @State private var viewModel: ViewModel
    
    init(entry: JournalEntry?) {
        self.entry = entry
        self.viewModel = ViewModel(entry: entry)
    }
    
    var body: some View {
        JournalEntryEditor(
//            createdAt: entry.createdAt,
            viewModel: viewModel
        )
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: Button {
            viewModel.save()
            self.mode.wrappedValue.dismiss()
        } label: { Text("Back") })
    }
}
