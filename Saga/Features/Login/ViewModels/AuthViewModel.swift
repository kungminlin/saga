//
//  AuthViewModel.swift
//  Saga
//
//  Created by Kung-Min Lin on 3/2/25.
//

import Foundation

@Observable class AuthViewModel {
    private let authManager = AuthManager.shared
    
    // Email auth
    var email = ""
    var password = ""
    var requireConfirmation = false
    
    // Auth state
    var isAuthenticated = false
    var requireOnboarding = false
    var error: Error?
    
    @MainActor
    func signInWithGoogle() {
        Task {
            self.error = nil
            
            do {
                try await authManager.signInWithGoogle()
                
                if authManager.profile == nil {
                    self.requireOnboarding = true
                } else {
                    self.isAuthenticated = true
                }
            } catch let error {
                print(error)
                self.error = error
            }
        }
    }
    
    func signUpWithEmailPassword() {
        Task {
            self.error = nil
            
            do {
                try await authManager.signInWithEmailPassword(email: email, password: password)
                
                if authManager.profile == nil {
                    self.requireOnboarding = true
                } else {
                    self.isAuthenticated = true
                }
                
                return
            } catch let error {
                print(error)
            }
            
            do {
                try await authManager.signUpWithEmailPassword(email: email, password: password)
                
                self.requireConfirmation = true
            } catch let error {
                print(error)
                self.error = error
            }
        }
    }
    
    func signInWithEmailPassword() {
        Task {
            self.error = nil
            
            do {
                try await authManager.signInWithEmailPassword(email: email, password: password)
                
                if authManager.profile == nil {
                    self.requireOnboarding = true
                } else {
                    self.isAuthenticated = true
                }
            } catch let error {
                print(error)
                self.error = error
            }
        }
    }
}
