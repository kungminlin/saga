//
//  AuthViewModel.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/27/25.
//

import Supabase
import GoogleSignIn

enum AuthError: Error {
    case GID(String)
    case Supabase(String)
}

class AuthManager {
    static let shared = AuthManager()
    
    var session: Session?
    var profile: UserProfile?
    
    @MainActor
    func signInWithGoogle() async throws {
        let googleAuthResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: UIApplication.shared.rootViewController!)
        
        guard let idToken = googleAuthResult.user.idToken?.tokenString else {
            throw AuthError.GID("No idToken found.")
        }
        
        let accessToken = googleAuthResult.user.accessToken.tokenString

        session = try await supabase.auth.signInWithIdToken(
          credentials: OpenIDConnectCredentials(
            provider: .google,
            idToken: idToken,
            accessToken: accessToken
          )
        )
        
        try await fetchUserProfile()
    }
    
    func signUpWithEmailPassword(email: String, password: String) async throws {
        let response = try await supabase.auth.signUp(email: email, password: password)
        
        session = response.session
    }
    
    func signInWithEmailPassword(email: String, password: String) async throws {
        session = try await supabase.auth.signIn(email: email, password: password)
        
        try await fetchUserProfile()
    }
    
    func fetchUserProfile() async throws {
        guard let session else { throw AuthError.Supabase("Not signed in.") }
        
        let profiles: [UserProfile] = try await supabase.from("user_profiles").select().eq("id", value: session.user.id).execute().value
        
        profile = profiles.first
    }
    
    func registerUserProfile(_ newProfile: UserProfile) async throws {
        let profiles: [UserProfile] = try await supabase.from("user_profiles").insert(newProfile).select().execute().value
        
        print("profilease", profiles)
        
        profile = profiles.first
    }
}


extension UIApplication {
    var rootViewController: UIViewController? {
        return (self.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController
    }
}
