//
//  HomeView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import SwiftUI

struct HomeView: View {
    private let catalog = MediaCatalogManager.shared
    
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("My Saga")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                
                HStack(alignment: .center) {
                    NavigationLink {} label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .font(.largeTitle)
                    }
                    NavigationLink {
                        JournalEntryView(entry: nil)
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.primary)
                            .font(.largeTitle)
                    }
                }
            }
            .padding()
            
            JournalEntries()
        }
        .onAppear {
            catalog.analyze()
        }
    }
}

#Preview {
    HomeView()
}
