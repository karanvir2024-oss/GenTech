//
//  PremiumSubscriptionView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-03-08.
//

import SwiftUI

struct PremiumSubscriptionView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var statusMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Premium Subscription")
                .font(.largeTitle)
                .bold()
            
            Text("Cost: $250")
                .font(.title2)
            
            Text("Your Credits: $\(authVM.credits)")
            
            Button("Confirm Purchase") {
                
                SubscriptionService.shared.buyPremium(authVM: authVM) { result in

                    DispatchQueue.main.async {
                        switch result {
                            
                        case .success(let newCredits):
                            
                            authVM.updateCredits(newCredits)
                            
                            statusMessage = "Premium activated!"

                        case .failure(let error):
                            
                            statusMessage = error.localizedDescription
                        }
                    }
                }
            }
            
            Text(statusMessage)
            
            Button("Close") {
                dismiss()
            }
        }
        .padding()
    }
}
