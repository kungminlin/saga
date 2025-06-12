//
//  OnboardingView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/28/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            HandleView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $viewModel.isComplete) {
            HomeView().navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    OnboardingView()
}
