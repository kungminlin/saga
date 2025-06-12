//
//  ContentView.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/18/25.
//

import SwiftUI

struct LandingView: View {
    @State private var offsetY = 0.0
    @State private var opacity = 0.0
    
    var body: some View {
        SignUpView()
        .onAppear {
            AuthorizationService.requestAuthorizations()
        }
    }
}

#Preview {
    LandingView()
}
