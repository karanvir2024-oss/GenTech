//
//  HomeFeedView.swift
//  gentech
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct HomeFeedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(0..<5) { _ in
                        StartupCardView()
                    }
                }
                .padding()
            }
            .navigationTitle("Featured Startups")
        }
    }
}
