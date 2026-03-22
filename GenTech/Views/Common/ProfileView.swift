//
//  ProfileView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var showPremiumSheet = false
    @State private var userImage: UIImage? = nil
    @State private var isLoadingImage = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            // MARK: - Profile Image
            if let image = userImage {
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
                    .overlay(Text("No Image").foregroundColor(.white))
            }
            
            // MARK: - User Info
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
            
            // MARK: - Buy Premium Button
            Button("Buy Premium ($250)") {
                showPremiumSheet = true
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(12)
            
            // MARK: - Logout Button
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
        .onAppear {
            loadProfileImage()
        }
        // Premium Sheet
        .sheet(isPresented: $showPremiumSheet) {
            PremiumSubscriptionView()
                .environmentObject(authVM)
        }
    }
    
    // MARK: - Load Profile Image from Firebase
    private func loadProfileImage() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        isLoadingImage = true
        
        let db = Firestore.firestore()
        db.collection("users").document(uid).getDocument { snapshot, error in
            isLoadingImage = false
            if let data = snapshot?.data(), let urlString = data["profileImageURL"] as? String, let url = URL(string: urlString) {
                downloadImage(from: url)
            }
        }
    }
    
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userImage = img
                }
            }
        }.resume()
    }
}
