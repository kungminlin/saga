//
//  SignUpView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/18/25.
//

import GoogleSignIn
import SwiftUI

struct SignUpView: View {
    @State var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 48) {
            VStack {
                Spacer().frame(height: 84)
                Text("Start your saga now.")
                    .bold()
                    .font(.title)
                Spacer().frame(height: 16)
                Text("Sign in to start recording your journey")
            }
            
            VStack {
                AuthButton(icon: "google", label: "Continue with Google", action: viewModel.signInWithGoogle)
            }
            
            HStack(spacing: 16) {
                VStack { Divider() }
                Text("or")
                VStack { Divider() }
            }
            
            VStack(spacing: 24) {
                Text("Sign up with email")
                    .font(.title3)
                    .fontWeight(.medium)
                
                TextField("\("saga@mysaga.com")", text: $viewModel.email)
                    .font(.body)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary))
                
                SecureField("*****", text: $viewModel.password)
                    .font(.body)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary))
                
                VStack(spacing: 12) {
                    Button {
                        viewModel.signUpWithEmailPassword()
                    } label: {
                        HStack {
                            Text("Sign up")
                                .bold()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.primary)
                        .background(RoundedRectangle(cornerRadius: 16).fill(.background))
                        .colorInvert()
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if (viewModel.requireConfirmation) {
                        Text("Please check your inbox for the confirmation email.")
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            
            NavigationLink {
                LoginView()
            } label: {
                Text("Already have an account?")
                Text("Log in").fontWeight(.semibold)
            }
            
            Spacer()
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
    SignUpView()
}
