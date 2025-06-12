//
//  HomeView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import SwiftUI

struct HomeView: View {
    private let catalog = MediaCatalogManager.shared
    @State private var viewModel = JournalViewModel()
    @State private var searchText = ""
    @State private var showingSearch = false
    @State private var showingNewEntry = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Header Section
                VStack(spacing: 16) {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("My Saga")
                                .font(.system(size: 34, weight: .bold))
                        }
                        Spacer()
                        
                        HStack(spacing: 16) {
                            Button {
                                showingSearch = true
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .font(.title3)
                                    .foregroundStyle(.primary)
                                    .frame(width: 44, height: 44)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                            
                            Button {
                                showingNewEntry = true
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.accentColor)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    
                    // Quick Stats
                    HStack(spacing: 16) {
                        StatCard(title: "Entries", value: "\(viewModel.entries.count)", icon: "book.fill")
                        StatCard(title: "Streak", value: "\(viewModel.entries.streaks) days", icon: "flame.fill")
                    }
                }
                .padding()
                
                // Journal Entries
                JournalEntries(viewModel: viewModel)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSearch) {
            SearchView(searchText: $searchText)
        }
        .sheet(isPresented: $showingNewEntry) {
            JournalEntryView(entry: nil)
        }
        .onAppear {
            catalog.analyze()
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundStyle(.secondary)
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
