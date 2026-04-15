 
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
    
    @Published var userPlan: Plan = .basic
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var successMessage: String = ""
    @Published var credits: Double = 500
    @Published var profileImage: UIImage?
    
    private let db = Firestore.firestore()
    
    // Computed properties
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
    
    // MARK: - SIGN UP
    func signUp(firstName: String,
                lastName: String,
                contactNumber: String,
                email: String,
                password: String,
                role: SignupRole) async {
        do {
            errorMessage = ""
            successMessage = ""
            
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
            self.userPlan = .basic
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - LOGIN
    func login(email: String, password: String) async {
        do {
            errorMessage = ""
            successMessage = ""
            
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let uid = result.user.uid
            
            let snapshot = try await db.collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: AppUser.self)
            
            self.currentUser = user
            self.userRole = user.role
            self.credits = user.credits ?? 500
            self.isLoggedIn = true
            self.userPlan = user.isPremium ? .premium : .basic
            
            await loadProfileImage()
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - LOGOUT
    func logout() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userRole = nil
            self.isLoggedIn = false
            self.credits = 500
            self.profileImage = nil
            
            //User Plan
            self.userPlan = .basic
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - RESET PASSWORD ✅ FIXED
    func resetPassword(email: String) async {
        
        let cleanEmail = email.trimmingCharacters(in: .whitespaces)
        
        guard !cleanEmail.isEmpty else {
            errorMessage = "Please enter your email"
            successMessage = ""
            return
        }
        
        do {
            try await Auth.auth().sendPasswordReset(withEmail: cleanEmail)
            
            errorMessage = ""
            successMessage = "Reset link sent to your email"
            
        } catch {
            errorMessage = error.localizedDescription
            successMessage = ""
        }
    }
    
    // MARK: - UPDATE CREDITS
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
    
    // MARK: - UPLOAD PROFILE IMAGE
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
    
    // MARK: - LOAD PROFILE IMAGE
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


