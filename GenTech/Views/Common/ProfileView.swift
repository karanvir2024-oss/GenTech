//
//  ProfileView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showPremiumSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            //Profile Image
            Button {
                showImagePicker = true
            } label: {
                if let image = authVM.profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                        .shadow(radius: 5)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 120, height: 120)
                        .overlay(Text("Tap to add").foregroundColor(.gray))
                }
            }
            
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
            
            Button("Logout") {
                authVM.logout()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
        .navigationTitle("Profile")
        
        //Image Picker
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
                .onDisappear {
                    if let img = selectedImage {
                        Task {
                            await authVM.uploadProfileImage(img)
                        }
                    }
                }
        }
        
        //Load image on open
        .task {
            await authVM.loadProfileImage()
        }
        
        //Premium Sheet
        .sheet(isPresented: $showPremiumSheet) {
            PremiumSubscriptionView()
                .environmentObject(authVM)
        }
    }
}
