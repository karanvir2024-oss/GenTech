//
//  FeatureRow.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-14.
//

//import SwiftUI
//
//struct FeatureRow: View {
//    
//    let icon: String
//    let text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(.yellow)
//            
//            Text(text)
//                .foregroundColor(.white)
//            
//            Spacer()
//        }
//    }
//}

import SwiftUI

struct FeatureRow: View {
    
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.yellow)
            
            Text(text)
                .foregroundColor(.white)
            
            Spacer()
        }
    }
}
