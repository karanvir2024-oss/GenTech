//
//  PremiumSubscriptionView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-03-08.
//

//import SwiftUI
//
//struct PremiumSubscriptionView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var statusMessage = ""
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            Text("Premium Subscription")
//                .font(.largeTitle)
//                .bold()
//            
//            Text("Cost: $250")
//                .font(.title2)
//            
//            Text("Your Credits: $\(authVM.credits)")
//            
//            Button("Confirm Purchase") {
//                
//                SubscriptionService.shared.buyPremium(authVM: authVM) { result in
//
//                    DispatchQueue.main.async {
//                        switch result {
//                            
//                        case .success(let newCredits):
//                            
//                            authVM.updateCredits(newCredits)
//                            
//                            statusMessage = "Premium activated!"
//
//                        case .failure(let error):
//                            
//                            statusMessage = error.localizedDescription
//                        }
//                    }
//                }
//            }
//            
//            Text(statusMessage)
//            
//            Button("Close") {
//                dismiss()
//            }
//        }
//        .padding()
//    }
//}

//import SwiftUI
//
//struct PremiumSubscriptionView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var statusMessage = ""
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            Text("Premium Subscription")
//                .font(.largeTitle)
//                .bold()
//            
//            Text("Cost: $250")
//                .font(.title2)
//            
//            Text("Your Credits: $\(authVM.credits)")
//            
//            Button("Confirm Purchase") {
//                Task {
//                    do {
//                        let newCredits = try await SubscriptionService.shared.buyPremium(authVM: authVM)
//                        statusMessage = "Premium activated! New credits: $\(newCredits)"
//                    } catch {
//                        statusMessage = error.localizedDescription
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.orange)
//            .foregroundColor(.white)
//            .cornerRadius(12)
//            
//            Text(statusMessage)
//                .foregroundColor(.green)
//            
//            Button("Close") {
//                dismiss()
//            }
//            .frame(maxWidth: .infinity)
//            .padding()
//            .background(Color.gray)
//            .foregroundColor(.white)
//            .cornerRadius(12)
//        }
//        .padding()
//    }
//}

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
            
            //Corrected formatting
            Text("Your Credits: $\(String(format: "%.2f", authVM.credits))")
            
            Button("Confirm Purchase") {
                Task {
                    do {
                        let newCredits = try await SubscriptionService.shared.buyPremium(authVM: authVM)
                        statusMessage = "Premium activated! Credits left: $\(String(format: "%.2f", newCredits))"
                    } catch {
                        statusMessage = error.localizedDescription
                    }
                }
            }
            
            Text(statusMessage)
                .foregroundColor(.green)
                .multilineTextAlignment(.center)
            
            Button("Close") {
                dismiss()
            }
        }
        .padding()
    }
}
