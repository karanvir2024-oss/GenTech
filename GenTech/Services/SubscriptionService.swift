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
    
    func buyPlan(authVM: AuthViewModel, plan: Plan) async throws -> Double {
        
        guard let user = authVM.currentUser else {
            throw NSError(domain: "", code: 0,
                          userInfo: [NSLocalizedDescriptionKey: "User not found"])
        }
        
        //Already same plan check (only meaningful for premium)
        if user.isPremium && plan == .premium {
            throw NSError(domain: "", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Already premium"])
        }
        
        let cost: Double
        
        switch plan {
        case .basic:
            cost = 50
        case .pro:
            cost = 120
        case .premium:
            cost = 250
        }
        
        if authVM.credits < cost {
            throw NSError(domain: "", code: 2,
                          userInfo: [NSLocalizedDescriptionKey: "Not enough credits"])
        }
        
        let newCredits = authVM.credits - cost
        
        //UPDATE LOCAL STATE
        await MainActor.run {
            authVM.updateCredits(newCredits)
            authVM.userPlan = plan
            
            if plan == .premium {
                authVM.currentUser?.isPremium = true
            }
        }
        
        //UPDATE FIRESTORE
        if let uid = authVM.currentUser?.id {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData([
                    "isPremium": plan == .premium
                ])
        }
        
        return newCredits
    }
}
