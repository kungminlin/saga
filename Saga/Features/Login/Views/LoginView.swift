//
//  LoginView.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/2/25.
//

import Foundation
import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @State var viewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Text("Log in")
                .bold()
                .font(.title)
            
            VStack(spacing: 24) {
                TextField("\("saga@mysaga.com")", text: $viewModel.email)
                    .font(.body)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary))
                
                SecureField("*****", text: $viewModel.password)
                    .font(.body)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary))
                
                Button {
                    viewModel.signInWithEmailPassword()
                } label: {
                    HStack {
                        Text("Log in")
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                    .background(RoundedRectangle(cornerRadius: 16).fill(.background))
                    .colorInvert()
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            Spacer().frame(height: 84)
            
            VStack {
                AuthButton(icon: "google", label: "Continue with Google", action: viewModel.signInWithGoogle)
            }
            
        }
        .padding()
        .onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
        }
        .navigationDestination(isPresented: $viewModel.isAuthenticated) {
            HomeView().navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $viewModel.requireOnboarding) {
            OnboardingView()
        }
    }
}

#Preview {
    LoginView()
}
