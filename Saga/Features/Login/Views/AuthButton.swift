//
//  AuthButton.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/27/25.
//

import SwiftUI

struct AuthButton: View {
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button { action() } label: {
            HStack {
                Image(icon)
                Text(label)
                    .bold()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(.secondary))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AuthButton(icon: "google", label: "Continue with Google", action: {})
}
