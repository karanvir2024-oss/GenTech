//
//  ProfileView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(authVM.userName) 
                .font(.largeTitle)
                .bold()
            
            Text(authVM.userEmail)
                .foregroundColor(.gray)
            
            Text("Role: \(authVM.roleText)")
                .foregroundColor(.blue)
            
            Spacer()
            
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
    }
}
