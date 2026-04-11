//
//  User.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//
import Foundation
import FirebaseFirestore

enum SignupRole: String, Codable {
    case investor
    case entrepreneur
}

@MainActor
struct AppUser: Codable, Identifiable {
    @DocumentID var id: String?
    var firstName: String
    var lastName: String
    var contactNumber: String
    var email: String
    var role: SignupRole
    var credits: Double?
    var isPremium: Bool?
    var profileImagePath: String?
}
