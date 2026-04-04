//
//  ChatViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import Foundation
import Combine

@MainActor
class ChatViewModel: ObservableObject {
    @Published var conversations: [Conversation] = []
    @Published var messages: [Message] = []

    func loadConversations(userId: String) {
        ChatService.shared.fetchConversations(userId: userId) { convos in
            DispatchQueue.main.async {
                self.conversations = convos
            }
        }
    }

    func startConversation(currentUserId: String, otherUserId: String, completion: @escaping (String) -> Void) {
        ChatService.shared.createConversation(currentUserId: currentUserId, otherUserId: otherUserId, completion: completion)
    }

    func sendMessage(conversationId: String, senderId: String, text: String) {
        ChatService.shared.sendMessage(conversationId: conversationId, senderId: senderId, text: text)
    }

    func listenMessages(conversationId: String) {
        ChatService.shared.listenMessages(conversationId: conversationId) { msgs in
            DispatchQueue.main.async {
                self.messages = msgs
            }
        }
    }
}
