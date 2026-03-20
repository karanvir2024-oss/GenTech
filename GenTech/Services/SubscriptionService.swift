//
//  SubscriptionService.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-03-08.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth



class SubscriptionService {

    static let shared = SubscriptionService()

    func buyPremium(authVM: AuthViewModel, completion: @escaping (Result<Double, Error>) -> Void) {

        guard let user = authVM.currentUser else { return }

        if user.isPremium == true {
            completion(.failure(NSError(domain: "", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "You are already a premium user"
            ])))
            return
        }

        if authVM.credits < 250 {
            completion(.failure(NSError(domain: "", code: 2, userInfo: [
                NSLocalizedDescriptionKey: "Not enough credits"
            ])))
            return
        }

        let newCredits = authVM.credits - 250

        authVM.updateCredits(newCredits)

        authVM.currentUser?.isPremium = true

        completion(.success(newCredits))
    }
}
