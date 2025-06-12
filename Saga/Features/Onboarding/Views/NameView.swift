//
//  NameView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/28/25.
//

import SwiftUI

struct NameView: View {
    private enum FocusedField { case name }
    @Bindable var viewModel: OnboardingView.ViewModel
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        VStack {
            VStack {
                TextField("Your Name", text: $viewModel.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .focused($focusedField, equals: .name)
            }
            .frame(maxHeight: .infinity)
            
            Button {
                viewModel.register()
            } label: {
                HStack {
                    Text("Sign Up")
                        .bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(.background))
                .colorInvert()
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .onAppear { focusedField = .name }
    }
}

#Preview {
    struct Preview: View {
        @State var viewModel = OnboardingView.ViewModel()
        var body: some View {
            NameView(viewModel: viewModel)
        }
    }
    
    return Preview()
}

