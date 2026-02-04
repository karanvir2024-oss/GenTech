//
//  StartupCardView.swift
//  gentech
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct StartupCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("AI Health Startup")
                .font(.headline)

            Text("Revolutionizing healthcare using AI diagnostics.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ProgressView(value: 0.6)
            Text("60% funded")
                .font(.caption)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
