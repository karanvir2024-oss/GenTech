 
import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import Combine
import UIKit

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var currentUser: AppUser?
    @Published var userRole: SignupRole?
    @Published var lastRole: SignupRole?
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var credits: Double = 500
    @Published var profileImage: UIImage?
    
    private let db = Firestore.firestore()
    
    //Computed properties
    var userName: String {
        guard let user = currentUser else { return "User" }
        return "\(user.firstName) \(user.lastName)"
    }
    
    var userEmail: String {
        currentUser?.email ?? ""
    }
    
    var roleText: String {
        userRole?.rawValue.capitalized ?? ""
    }
    
    // Sign Up
    func signUp(firstName: String,
                lastName: String,
                contactNumber: String,
                email: String,
                password: String,
                role: SignupRole) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = result.user.uid
            
            let user = AppUser(
                id: uid,
                firstName: firstName,
                lastName: lastName,
                contactNumber: contactNumber,
                email: email,
                role: role,
                credits: 500,
                isPremium: false
            )
            
            try db.collection("users").document(uid).setData(from: user)
            
            self.currentUser = user
            self.userRole = role
            self.credits = user.credits ?? 500
            self.isLoggedIn = true
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Login
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let uid = result.user.uid
            
            let snapshot = try await db.collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: AppUser.self)
            
            self.currentUser = user
            self.userRole = user.role
            self.credits = user.credits ?? 500
            self.isLoggedIn = true
            
            // Load profile image after login
            await loadProfileImage()
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    //Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userRole = nil
            self.isLoggedIn = false
            self.credits = 500
            self.profileImage = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Update Credits
    func updateCredits(_ newCredits: Double) {
        self.credits = newCredits
        self.currentUser?.credits = newCredits
        
        if let uid = currentUser?.id {
            db.collection("users").document(uid).updateData([
                "credits": newCredits
            ]) { error in
                if let error = error {
                    print("Failed to update credits:", error.localizedDescription)
                }
            }
        }
    }
    
    // Upload Profile Image
    func uploadProfileImage(_ image: UIImage) async {
        guard let uid = Auth.auth().currentUser?.uid,
              let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = Storage.storage().reference().child("profileImages/\(uid).jpg")
        
        do {
            _ = try await ref.putDataAsync(data, metadata: nil)
            
            await MainActor.run {
                self.profileImage = image
            }
        } catch {
            print("Upload error:", error.localizedDescription)
        }
    }
    
    // Load Profile Image
    func loadProfileImage() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference().child("profileImages/\(uid).jpg")
        
        do {
            let data = try await ref.data(maxSize: 2 * 1024 * 1024)
            if let image = UIImage(data: data) {
                await MainActor.run {
                    self.profileImage = image
                }
            }
        } catch {
            print("Load error:", error.localizedDescription)
        }
    }
}

