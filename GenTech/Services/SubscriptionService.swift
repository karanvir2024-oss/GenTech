//
//  SubscriptionService.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-03-08.
//

import Foundation
import FirebaseFirestore

class SubscriptionService {
    
    static let shared = SubscriptionService()
    
    func buyPremium(authVM: AuthViewModel) async throws -> Double {
        guard let user = authVM.currentUser else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        if user.isPremium == true {
            throw NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Already premium"])
        }
        
        if authVM.credits < 250 {
            throw NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "Not enough credits"])
        }
        
        let newCredits = authVM.credits - 250
        
        // Update credits locally
        authVM.updateCredits(newCredits)
        authVM.currentUser?.isPremium = true
        
        // Update Firestore
        if let uid = authVM.currentUser?.id {
            try await Firestore.firestore().collection("users").document(uid).updateData([
                "isPremium": true
            ])
        }
        
        return newCredits
    }
}

