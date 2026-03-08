//
//  RoleSelectionView.swift
//  gentech
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct RoleSelectionView: View {
    let roles = ["Entrepreneur", "Investor", "Mentor", "Learner"]

    var body: some View {
        VStack(spacing: 20) {
            Text("Select Your Role")
                .font(.title2)
                .fontWeight(.semibold)

            ForEach(roles, id: \.self) { role in
                Button(role) {
                    // Save role to Firestore later
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            }
        }
        .padding()
    }
}
