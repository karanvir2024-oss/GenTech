//
//  ChatViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import Foundation
//import Combine
//
//enum ChatError: Error, LocalizedError {
//    case freePlanLimit
//
//    var errorDescription: String? {
//        switch self {
//        case .freePlanLimit:
//            return "Free plan allows only 3 conversations. Upgrade to Premium."
//        }
//    }
//}
//
//class ChatViewModel: ObservableObject {
//    
//    @Published var messages: [Message] = []
//    @Published var conversations: [Conversation] = []
//    
//    func startConversation(currentUserId: String,
//                           otherUserId: String,
//                           isPremium: Bool,
//                           completion: @escaping (Result<String, ChatError>) -> Void) {
//        
//        if !isPremium && conversations.count >= 3 {
//            completion(.failure(.freePlanLimit))
//            return
//        }
//        
//        ChatService.shared.createConversation(
//            currentUserId: currentUserId,
//            otherUserId: otherUserId
//        ) { id in
//            completion(.success(id))
//        }
//    }
//
//    func sendMessage(conversationId: String,
//                     senderId: String,
//                     text: String) {
//        
//        ChatService.shared.sendMessage(
//            conversationId: conversationId,
//            senderId: senderId,
//            text: text
//        )
//    }
//    
//    func listen(conversationId: String) {
//        ChatService.shared.listenForMessages(conversationId: conversationId) { messages in
//            DispatchQueue.main.async {
//                self.messages = messages
//            }
//        }
//    }
//    
//    func loadConversations(userId: String) {
//        ChatService.shared.fetchConversations(for: userId) { conversations in
//            DispatchQueue.main.async {
//                self.conversations = conversations
//            }
//        }
//    }
//}
