//
//  ProfileView.swift
//  
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)

                Text("Your Name")
                    .font(.title2)

                Text("Entrepreneur")
                    .foregroundColor(.secondary)

                Button("Edit Profile") {}

                Button("Logout") {}
                    .foregroundColor(.red)
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}


