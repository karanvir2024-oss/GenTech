//
//  AuthViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var currentUser: AppUser?
    @Published var userRole: SignupRole?
    
    //store role before logout
    @Published var lastRole: SignupRole?
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    private let db = Firestore.firestore()
    
    //Computed properties for UI
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
    
    // Signup Function
    func signUp(firstName: String, lastName: String, contactNumber: String, email: String, password: String, role: SignupRole) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let uid = result.user.uid
            
            // Create AppUser
            let user = AppUser(
                id: uid,
                firstName: firstName,
                lastName: lastName,
                contactNumber: contactNumber,
                email: email,
                role: role
            )
            
            // Store in Firestore
            try db.collection("users").document(uid).setData(from: user)
            
            // Update published properties
            self.currentUser = user
            self.userRole = role
            self.isLoggedIn = true
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Login Function
    func login(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let uid = result.user.uid
            
            let snapshot = try await db.collection("users").document(uid).getDocument()
            
            let user = try snapshot.data(as: AppUser.self)
            
            self.currentUser = user
            self.userRole = user.role
            self.isLoggedIn = true
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // Logout Function
    func logout() {
        do {
            try Auth.auth().signOut()
            self.currentUser = nil
            self.userRole = nil
            self.isLoggedIn = false
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }    
}
