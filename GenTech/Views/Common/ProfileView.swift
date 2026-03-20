//
//  ProfileView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct ProfileView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            Text(authVM.userName) 
//                .font(.largeTitle)
//                .bold()
//            
//            Text(authVM.userEmail)
//                .foregroundColor(.gray)
//            
//            Text("Role: \(authVM.roleText)")
//                .foregroundColor(.blue)
//            
//            Text("Credits: $\(authVM.credits, specifier: "%.2f")")
//                            .font(.headline)
//                            .foregroundColor(.green)
//                        
//                        Button("Buy Premium ($250)") {
//                            showPremiumSheet = true
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//            
//            Spacer()
//            
//            Button(action: {
//                authVM.logout()
//            }) {
//                Text("Logout")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//            }
//        }
//        .padding()
//        .navigationTitle("Profile")
//    }
//}

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var showPremiumSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(authVM.userName)
                .font(.largeTitle)
                .bold()
            
            Text(authVM.userEmail)
                .foregroundColor(.gray)
            
            Text("Role: \(authVM.roleText)")
                .foregroundColor(.blue)
            
            Text("Credits: $\(authVM.credits, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.green)
            
            Button("Buy Premium ($250)") {
                showPremiumSheet = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            //Spacer()
            
            Button(action: {
                authVM.logout()
                    }) {
                        Text("Logout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
        .padding()
        .navigationTitle("Profile")
        //.navigationBarBackButtonHidden(true)

        
        // Premium Sheet
        .sheet(isPresented: $showPremiumSheet) {
            PremiumSubscriptionView()
                .environmentObject(authVM)
        }
    }
}
