//
//  FilterChip.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-11.
//

import SwiftUI

struct FilterChip: View {
    
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(20)
        }
    }
}
