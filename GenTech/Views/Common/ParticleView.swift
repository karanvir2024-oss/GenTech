//
//  ParticleView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-14.
//

import SwiftUI

struct ParticleView: View {
    
    @State private var move = false
    
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<20, id: \.self) { _ in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: CGFloat.random(in: 5...10))
                    .position(
                        x: CGFloat.random(in: 0...geo.size.width),
                        y: move ? -50 : geo.size.height + 50
                    )
                    .animation(
                        Animation.linear(duration: Double.random(in: 5...10))
                            .repeatForever(autoreverses: false),
                        value: move
                    )
            }
        }
        .onAppear { move = true }
        .ignoresSafeArea()
    }
}
