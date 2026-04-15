//
//  SettingsView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-14.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK: - Validation
    var isPasswordValid: Bool {
        !newPassword.isEmpty &&
        newPassword.count >= 6 &&
        newPassword == confirmPassword
    }
    
    var body: some View {
        
        ZStack {
            
            //Background
            LinearGradient(
                colors: [.black, .indigo, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                
                VStack(spacing: 20) {
                    
                    //PROFILE CARD
                    VStack(spacing: 12) {
                        
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text(authVM.userName)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                        Text(authVM.userEmail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text(authVM.roleText)
                            .font(.caption)
                            .foregroundColor(.blue)
                            .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    //CHANGE PASSWORD
                    VStack(spacing: 15) {
                        
                        Text("Change Password")
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        SecureField("New Password", text: $newPassword)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                            .padding()
                            .background(Color.white.opacity(0.1))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        
                        Button {
                            Task {
                                await changePassword()
                            }
                        } label: {
                            
                            if isLoading {
                                ProgressView()
                                    .tint(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            } else {
                                Text("Update Password")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                        }
                        .background(isPasswordValid ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .disabled(!isPasswordValid || isLoading)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    //LOGOUT
                    Button {
                        authVM.logout()
                    } label: {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.top, 20)
            }
        }
        
        // ALERT
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Settings"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    //CHANGE PASSWORD
    func changePassword() async {
        
        guard isPasswordValid else {
            alertMessage = "Passwords must match and be at least 6 characters."
            showAlert = true
            return
        }
        
        isLoading = true
        
        do {
            guard let user = Auth.auth().currentUser else {
                throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No user logged in"])
            }
            
            try await user.updatePassword(to: newPassword)
            
            alertMessage = "Password updated successfully"
            showAlert = true
            
            newPassword = ""
            confirmPassword = ""
            
        } catch {
            alertMessage = error.localizedDescription
            showAlert = true
        }
        
        isLoading = false
    }
}
