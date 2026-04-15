//
//  PlanCard.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-14.
//

//import SwiftUI
//
//struct PlanCard: View {
//    
//    let plan: Plan
//    let isSelected: Bool
//    
//    var body: some View {
//        VStack(spacing: 8) {
//            
//            Text(plan.rawValue)
//                .foregroundColor(.white)
//                .font(.headline)
//            
//            Text(plan.price)
//                .foregroundColor(.green)
//                .font(.subheadline)
//        }
//        .frame(width: 110, height: 110)
//        .background(
//            ZStack {
//                if isSelected {
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(.ultraThinMaterial)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 20)
//                                .stroke(
//                                    LinearGradient(
//                                        colors: [.purple, .blue],
//                                        startPoint: .top,
//                                        endPoint: .bottom
//                                    ),
//                                    lineWidth: 2
//                                )
//                        )
//                } else {
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(Color.white.opacity(0.05))
//                }
//            }
//        )
//        .scaleEffect(isSelected ? 1.08 : 1)
//        .animation(.spring(), value: isSelected)
//    }
//}

import SwiftUI

struct PlanCard: View {
    
    let plan: Plan
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text(plan.rawValue)
                .font(.headline)
                .foregroundColor(.white)
            
            Text(plan.price)
                .foregroundColor(.green)
                .font(.subheadline)
        }
        .frame(width: 110, height: 110)
        .background(
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.purple, lineWidth: 2)
                        )
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.05))
                }
            }
        )
        .scaleEffect(isSelected ? 1.08 : 1)
        .animation(.spring(), value: isSelected)
    }
}
