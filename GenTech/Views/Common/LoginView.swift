//
//  LoginView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isLoadingReset = false
    
    // EMAIL VALIDATION
    var isValidEmail: Bool {
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex)
            .evaluate(with: email)
    }
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(
                colors: [.black, .indigo, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Login to continue investing")
                        .foregroundColor(.white.opacity(0.7))
                }
                
                VStack(spacing: 16) {
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    // FORGOT PASSWORD (FIXED)
                    HStack {
                        Spacer()
                        
                        Button {
                            Task {
                                await handleForgotPassword()
                            }
                        } label: {
                            
                            if isLoadingReset {
                                ProgressView()
                                    .tint(.white)
                                    .font(.caption)
                            } else {
                                Text("Forgot Password?")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                        }
                        .disabled(!isValidEmail || isLoadingReset)
                    }
                    
                    // ERROR
                    if !authVM.errorMessage.isEmpty {
                        Text(authVM.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    // LOGIN
                    Button {
                        Task {
                            await authVM.login(email: email, password: password)
                        }
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Password Reset"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
     //   .navigationBarBackButtonHidden(true)
        
    }
    
    // MARK: - FIXED RESET FUNCTION
    func handleForgotPassword() async {
        
        guard isValidEmail else {
            alertMessage = "Please enter a valid email first"
            showAlert = true
            return
        }
        
        isLoadingReset = true
        
        await authVM.resetPassword(email: email)
        
        isLoadingReset = false
        
        if authVM.errorMessage.isEmpty {
            alertMessage = "Reset link sent to \(email)"
        } else {
            alertMessage = authVM.errorMessage
        }
        
        showAlert = true
    }
}
