//
//  CreatePitchView.swift
//  
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct CreatePitchView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var fundingGoal = ""

    var body: some View {
        Form {
            Section(header: Text("Startup Info")) {
                TextField("Startup Name", text: $title)
                TextField("Funding Goal", text: $fundingGoal)
                TextEditor(text: $description)
                    .frame(height: 120)
            }

            Button("Upload Pitch Deck") {
                // Firebase Storage
            }

            Button("Post Startup") {
                // Save to Firestore
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Create Pitch")
    }
}

