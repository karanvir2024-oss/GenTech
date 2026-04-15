//
//  SignUpView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var contactNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signupRole: SignupRole = .investor
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        
        ZStack {
            
            //Background Gradient (same as Login)
            LinearGradient(
                colors: [.black, .indigo, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer()
                
                //Title Section
                VStack(spacing: 8) {
                    Text("Create Account")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Join GenTech and start investing")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.subheadline)
                }
                
                //Form Card
                VStack(spacing: 14) {
                    
                    Group {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Contact Number", text: $contactNumber)
                            .keyboardType(.phonePad)
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .placeholderStyle()
                    
                    // Role Picker
                    VStack(spacing: 8) {
                        Text("Select Role")
                            .foregroundColor(.white.opacity(0.8))
                            .font(.headline)
                        
                        Picker("Role", selection: $signupRole) {
                            Text("Investor").tag(SignupRole.investor)
                            Text("Entrepreneur").tag(SignupRole.entrepreneur)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                    }
                    
                    // Error
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    // Sign Up Button
                    Button {
                        
                        if firstName.isEmpty ||
                            lastName.isEmpty ||
                            contactNumber.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty {
                            
                            errorMessage = "Please fill in all fields"
                            return
                        }
                        
                        errorMessage = ""
                        
                        Task {
                            await authVM.signUp(
                                firstName: firstName,
                                lastName: lastName,
                                contactNumber: contactNumber,
                                email: email,
                                password: password,
                                role: signupRole
                            )
                        }
                        
                    } label: {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.green],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
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
       // .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
        
//        //BACK BUTTON (same style as Login)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                        .foregroundColor(.white)
//                        .font(.system(size: 18, weight: .semibold))
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        
        // Error sync from VM
        .onReceive(authVM.$errorMessage) { newValue in
            self.errorMessage = newValue
        }
    }
}
