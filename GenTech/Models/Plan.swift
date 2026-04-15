//
//  Plan.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-14.
//

import Foundation

enum Plan: String, CaseIterable {
    case basic = "Basic"
    case pro = "Pro"
    case premium = "Premium"
    
    var price: String {
        switch self {
        case .basic: return "$50"
        case .pro: return "$120"
        case .premium: return "$250"
        }
    }
    
    var features: [String] {
        switch self {
        case .basic:
            return [
                "Limited access",
                "Standard support",
                "Basic features"
            ]
            
        case .pro:
            return [
                "Faster access",
                "Priority support",
                "More features unlocked"
            ]
            
        case .premium:
            return [
                "Unlimited access",
                "VIP support",
                "All features unlocked",
                "No restrictions"
            ]
        }
    }
}
