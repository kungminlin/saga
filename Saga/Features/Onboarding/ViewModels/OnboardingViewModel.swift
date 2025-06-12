//
//  OnboardingViewModel.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/28/25.
//

import Foundation

extension OnboardingView {
    @Observable class ViewModel {
        let authManager = AuthManager.shared
        
        var name: String
        var handle: String
        var error: Error?
        var isComplete = false
        
        init() {
            self.name = ""
            self.handle = ""
        }
        
        @MainActor
        func register() {
            Task {
                do {
                    try await authManager.registerUserProfile(UserProfile(
                        id: authManager.session!.user.id,
                        handle: handle,
                        display_name: name,
                        profile_image_url: nil,
                        bio: nil,
                        created_at: nil
                    ))
                    
                    isComplete = true
                } catch let error {
                    print(error)
                    self.error = error
                }
                
            }
        }
    }
}
