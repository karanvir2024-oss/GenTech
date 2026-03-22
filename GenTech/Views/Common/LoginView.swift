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
//        NavigationView {
//            VStack(spacing: 30) {
//                
//                Text("Login")
//                    .font(.largeTitle)
//                    .bold()
//                
//                TextField("Email", text: $email)
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.horizontal)
//                
//                if !authVM.errorMessage.isEmpty {
//                    Text(authVM.errorMessage)
//                        .foregroundColor(.red)
//                        .padding(.horizontal)
//                }
//                
//                Button(action: {
//                    Task {
//                        await authVM.login(email: email, password: password)
//                    }
//                }) {
//                    Text("Login")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding(.horizontal)
//                
//                Spacer()
//                
//                // NavigationLink triggered by login
//                NavigationLink(
//                    destination: RoleBasedView(),
//                    isActive: $authVM.isLoggedIn,
//                    label: { EmptyView() }
//                )
//            }
//            .padding(.top, 50)
//        }
//    }
//}

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 30) {
            
            Text("Login")
                .font(.largeTitle)
                .bold()
            
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if !authVM.errorMessage.isEmpty {
                Text(authVM.errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }
            
            Button(action: {
                Task {
                    print("Login button tapped")
                    await authVM.login(email: email, password: password)
                }
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 50)
        .navigationTitle("Login") // ✅ title
        .navigationBarTitleDisplayMode(.inline) // ✅ centered
    }
}
