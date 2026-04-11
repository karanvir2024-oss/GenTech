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
            
            // BACKGROUND IMAGE (if exists)
            if !project.imageURL.isEmpty {
                AsyncImage(url: URL(string: project.imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
            } else {
                // fallback gradient if no image
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        LinearGradient(
                            colors: [Color.indigo, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 200)
            }

            // DARK OVERLAY for readability
            LinearGradient(
                colors: [Color.black.opacity(0.0), Color.black.opacity(0.6)],
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(20)

            // TEXT CONTENT
            VStack(alignment: .leading, spacing: 8) {
                
                Text(project.title)
                    .font(.headline)
                    .bold()
                    .foregroundColor(.white)
                
                Text(project.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(3)
                
                Text("Funds: $\(project.fundsNeeded, specifier: "%.2f")")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.top, 4)
            }
            .padding()
        }
        .frame(height: 200)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 5)
    }
}
