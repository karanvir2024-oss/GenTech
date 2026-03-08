//
//  ProjectCardView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct ProjectCardView: View {
    
    var project: Project
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color.indigo, Color.purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(project.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Text(project.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(4)
                
                //Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 4)
            }
            .padding()
        }
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 5)
    }
}
