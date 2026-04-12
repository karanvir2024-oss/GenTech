//
//  LoginView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


//import SwiftUI
//
//struct LoginView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    
//    @State private var email = ""
//    @State private var password = ""
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            
////            Text("Login")
////                .font(.largeTitle)
////                .bold()
////            
//            TextField("Email", text: $email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//            
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//            
//            if !authVM.errorMessage.isEmpty {
//                Text(authVM.errorMessage)
//                    .foregroundColor(.red)
//                    .padding(.horizontal)
//            }
//            
//            Button(action: {
//                Task {
//                    print("Login button tapped")
//                    await authVM.login(email: email, password: password)
//                }
//            }) {
//                Text("Login")
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//            
//            Spacer()
//        }
//        .padding(.top, 50)
//        .navigationTitle("Login") 
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

//import SwiftUI
//
//struct LoginView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @Environment(\.dismiss) var dismiss   // ✅ ADD THIS
//    
//    @State private var email = ""
//    @State private var password = ""
//    
//    var body: some View {
//        VStack(spacing: 30) {
//            
//            TextField("Email", text: $email)
//                .keyboardType(.emailAddress)
//                .autocapitalization(.none)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//            
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding(.horizontal)
//            
//            if !authVM.errorMessage.isEmpty {
//                Text(authVM.errorMessage)
//                    .foregroundColor(.red)
//                    .padding(.horizontal)
//            }
//            
//            Button(action: {
//                Task {
//                    print("Login button tapped")
//                    await authVM.login(email: email, password: password)
//                }
//            }) {
//                Text("Login")
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            .padding(.horizontal)
//            
//            Spacer()
//        }
//        .padding(.top, 50)
//        .navigationTitle("Login")
//        .navigationBarTitleDisplayMode(.inline)
//        
//        //ADD BACK BUTTON
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    Image(systemName: "chevron.left")
//                }
//            }
//        }
//    }
//}



import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        ZStack {
            
            // 🔥 Background Gradient
            LinearGradient(
                colors: [.black, .indigo, .purple],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                // 🔥 Title
                VStack(spacing: 8) {
                    Text("Welcome Back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Login to continue investing")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.subheadline)
                }
                
                // 🧊 Form Card
                VStack(spacing: 16) {
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .placeholderStyle()
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .placeholderStyle()
                    
                    if !authVM.errorMessage.isEmpty {
                        Text(authVM.errorMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    Button {
                        Task {
                            await authVM.login(email: email, password: password)
                        }
                    } label: {
                        Text("Login")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue],
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
       // .navigationTitle("Login")
        .navigationBarTitleDisplayMode(.inline)
        
        // 🔙 NAV BAR BACK BUTTON (TOP LEFT)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                }
            }
        }
        .navigationBarBackButtonHidden(true) // hides default back button
    }
}
