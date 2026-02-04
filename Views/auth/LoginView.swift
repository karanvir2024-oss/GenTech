//
//  LoginView.swift
//  gentech
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showRoleSelection = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("GenEnt")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)

                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)

                Button("Login") {
                    // Firebase login later
                }
                .buttonStyle(.borderedProminent)

                Button("Sign Up") {
                    showRoleSelection = true
                }

                Button("Continue as Guest") {
                    // Guest login
                }
                .foregroundColor(.gray)
            }
            .padding()
            .navigationDestination(isPresented: $showRoleSelection) {
               // RoleSelectionView()
            }
        }
    }
}

