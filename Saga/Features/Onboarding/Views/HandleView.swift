//
//  HandleView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/28/25.
//

import SwiftUI

struct HandleView: View {
    private enum FocusedField { case handle }
    @Bindable var viewModel: OnboardingView.ViewModel
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            HStack {
                TextField("your_username", text: $viewModel.handle)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .focused($focusedField, equals: .handle)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .onChange(of: viewModel.handle) {
                        viewModel.handle = viewModel.handle.lowercased().trimmingCharacters(in: .whitespaces)
                    }
            }
            .frame(maxHeight: .infinity)
            
            NavigationLink {
                NameView(viewModel: viewModel)
            } label: {
                HStack {
                    Text("Continue")
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(.quinary))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onAppear { focusedField = .handle }
    }
}

#Preview {
    struct Preview: View {
        @State var viewModel = OnboardingView.ViewModel()
        var body: some View {
            HandleView(viewModel: viewModel)
        }
    }
    
    return Preview()
}
