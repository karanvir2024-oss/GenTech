//
//  ChatViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import Foundation
//import Combine
//
//@MainActor
//class ChatViewModel: ObservableObject {
//    @Published var conversations: [Conversation] = []
//    @Published var messages: [Message] = []
//
//    func loadConversations(userId: String) {
//        ChatService.shared.fetchConversations(userId: userId) { convos in
//            DispatchQueue.main.async {
//                self.conversations = convos
//            }
//        }
//    }
//
//    func startConversation(currentUserId: String, otherUserId: String, completion: @escaping (String) -> Void) {
//        ChatService.shared.createConversation(currentUserId: currentUserId, otherUserId: otherUserId, completion: completion)
//    }
//
//    func sendMessage(conversationId: String, senderId: String, text: String) {
//        ChatService.shared.sendMessage(conversationId: conversationId, senderId: senderId, text: text)
//    }
//
//    func listenMessages(conversationId: String) {
//        ChatService.shared.listenMessages(conversationId: conversationId) { msgs in
//            DispatchQueue.main.async {
//                self.messages = msgs
//            }
//        }
//    }
//}
//
//

//import Foundation
//import Combine
//
//@MainActor
//class ChatViewModel: ObservableObject {
//    @Published var conversations: [Conversation] = []
//    @Published var messages: [Message] = []
//    
//    @Published var chatUserName: String = "Chat"   // ✅ NEW
//
//    // MARK: - Load Conversations
//    func loadConversations(userId: String) {
//        ChatService.shared.fetchConversations(userId: userId) { convos in
//            DispatchQueue.main.async {
//                self.conversations = convos
//            }
//        }
//    }
//
//    // MARK: - Start Conversation
//    func startConversation(currentUserId: String, otherUserId: String, completion: @escaping (String) -> Void) {
//        ChatService.shared.createConversation(
//            currentUserId: currentUserId,
//            otherUserId: otherUserId,
//            completion: completion
//        )
//    }
//
//    // MARK: - Send Message
//    func sendMessage(conversationId: String, senderId: String, text: String) {
//        ChatService.shared.sendMessage(
//            conversationId: conversationId,
//            senderId: senderId,
//            text: text
//        )
//    }
//
//    // MARK: - Listen Messages
//    func listenMessages(conversationId: String) {
//        ChatService.shared.listenMessages(conversationId: conversationId) { msgs in
//            DispatchQueue.main.async {
//                self.messages = msgs
//            }
//        }
//    }
//
//    // MARK: - 🔥 NEW: Load Other User Name
//    func loadChatUser(conversation: Conversation, currentUserId: String) {
//        // Get OTHER user ID
//        guard let otherUserId = conversation.participants.first(where: { $0 != currentUserId }) else {
//            return
//        }
//
//        // Fetch user from Firestore
//        ChatService.shared.fetchUser(userId: otherUserId) { user in
//            DispatchQueue.main.async {
//                if let user = user {
//                    self.chatUserName = "\(user.firstName) \(user.lastName)"
//                } else {
//                    self.chatUserName = "User"
//                }
//            }
//        }
//    }
//}


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

    // ✅ UPDATED
    func startConversation(
        currentUserId: String,
        otherUserId: String,
        otherUserName: String,
        completion: @escaping (String) -> Void
    ) {
        ChatService.shared.createConversation(
            currentUserId: currentUserId,
            otherUserId: otherUserId,
            otherUserName: otherUserName,
            completion: completion
        )
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
