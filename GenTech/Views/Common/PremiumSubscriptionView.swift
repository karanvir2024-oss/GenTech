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
    
    @State private var selectedPlan: Plan = .premium
    @State private var statusMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        
        ZStack {
            
            //Background
            LinearGradient(
                colors: [.black, .purple, .indigo],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ParticleView()
            
            //BACK BUTTON (TOP LEFT)
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            
            //MAIN CONTENT
            VStack(spacing: 25) {
                
                Spacer()
                
                VStack(spacing: 10) {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.yellow)
                    
                    Text("Upgrade to Premium")
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                    Text("Choose your plan")
                        .foregroundColor(.gray)
                }
                
                //PLAN SELECTION
                HStack(spacing: 15) {
                    ForEach(Plan.allCases, id: \.self) { plan in
                        PlanCard(
                            plan: plan,
                            isSelected: selectedPlan == plan
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                selectedPlan = plan
                            }
                        }
                    }
                }
                
                //FEATURES
                VStack(spacing: 12) {
                    ForEach(selectedPlan.features, id: \.self) { feature in
                        FeatureRow(
                            icon: "checkmark.circle.fill",
                            text: feature
                        )
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
                
                //CREDITS
                Text("Credits: $\(String(format: "%.2f", authVM.credits))")
                    .foregroundColor(.white)
                
                //BUTTON
                Button {
                    Task {
                        isLoading = true
                        
                        do {
                            let newCredits = try await SubscriptionService.shared.buyPlan(
                                authVM: authVM,
                                plan: selectedPlan
                            )
                            
                            statusMessage = "🎉 Success! New credits: \(newCredits)"
                            
                        } catch {
                            statusMessage = error.localizedDescription
                        }
                        
                        isLoading = false
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(.blue)
                            .frame(height: 55)
                        
                        if isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Upgrade Now")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .padding(.horizontal)
                
                //STATUS MESSAGE
                if !statusMessage.isEmpty {
                    Text(statusMessage)
                        .foregroundColor(.green)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Subscription")
        .navigationBarTitleDisplayMode(.inline)
    }
}
