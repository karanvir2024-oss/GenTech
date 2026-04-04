//
//  Message.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import Foundation
import FirebaseFirestore

struct Message: Identifiable, Codable, Equatable {
    @DocumentID var id: String?
    var senderId: String
    var text: String
    var timestamp: Date
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id &&
        lhs.senderId == rhs.senderId &&
        lhs.text == rhs.text &&
        lhs.timestamp == rhs.timestamp
    }
}
