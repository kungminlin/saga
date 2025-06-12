//
//  JournalEditor.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/19/25.
//

import SwiftUI
import PhotosUI

struct JournalEntryEditor: View {
    private let catalog = MediaCatalogManager.shared
    private let consultant = ContentConsultant()
    
//    let createdAt: Date
    
    @Bindable var viewModel: JournalEntryView.ViewModel
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    @State private var recommendedImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Untitled", text: $viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let recommendedImage {
                Image(uiImage: recommendedImage)
                    .resizable()
                    .scaledToFit()
            }
            
//            Text("Created at \(createdAt.formatted(.dateTime))")
//                .font(.subheadline)
            
            if !selectedImages.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<selectedImages.count, id: \.self) { i in
                            selectedImages[i]
                                .resizable()
                                .scaledToFit()
                        }
                    }
                }
            }
            
            TextEditor(text: $viewModel.body) .onChange(of: viewModel.body) {
//                recommendedImage = consultant.getSuggestions(for: viewModel.body)
            }
        }
        .padding(16)
        .overlay(alignment: .bottom) {
            PhotosPicker(selection: $pickerItems, matching: .any(of: [.images])) {
                Image(systemName: "photo.fill")
                    .frame(width: 52, height: 52)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(15)
                    .fontWeight(.heavy)
            }
            .onChange(of: pickerItems) {
                Task {
                    selectedImages.removeAll()
                    
                    for item in pickerItems {
                        if let loadedImage = try await item.loadTransferable(type: Image.self) {
                            selectedImages.append(loadedImage)
                        }
                    }
                }
            }
        }
    }
}
