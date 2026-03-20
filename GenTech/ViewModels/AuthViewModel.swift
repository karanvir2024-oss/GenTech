
import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    
    @Published var currentUser: AppUser?
    @Published var userRole: SignupRole?
    
    // store role before logout
    @Published var lastRole: SignupRole?
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    // Default credits
    @Published var credits: Double = 500
    
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
    
    // MARK: - Signup
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
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Logout
    func logout() {
        do {
            try Auth.auth().signOut()
            
            self.currentUser = nil
            self.userRole = nil
            self.isLoggedIn = false
            self.credits = 500
            
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    // MARK: - Update Credits
    func updateCredits(_ newCredits: Double) {
        self.credits = newCredits
        self.currentUser?.credits = newCredits
        
        if let uid = currentUser?.id {
            db.collection("users").document(uid).updateData([
                "credits": newCredits
            ])
        }
    }
}
