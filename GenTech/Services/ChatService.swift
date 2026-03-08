//import Foundation
//import FirebaseFirestore
//import FirebaseFirestore
//
//class ChatService {
//    
//    static let shared = ChatService()
//    private let db = Firestore.firestore()
//    
//    // MARK: - Create or Get Conversation
//    func createConversation(currentUserId: String,
//                            otherUserId: String,
//                            completion: @escaping (String) -> Void) {
//        
//        let conversationId = [currentUserId, otherUserId].sorted().joined(separator: "_")
//        
//        let conversation = Conversation(
//            id: conversationId,
//            participants: [currentUserId, otherUserId],
//            lastMessage: "",
//            timestamp: Date()
//        )
//        
//        do {
//            try db.collection("conversations")
//                .document(conversationId)
//                .setData(from: conversation, merge: true)
//            completion(conversationId)
//        } catch {
//            print("Error creating conversation: \(error.localizedDescription)")
//        }
//    }
//    
//    // MARK: - Send Message
//    func sendMessage(conversationId: String,
//                     senderId: String,
//                     text: String) {
//        
//        let message = Message(
//            id: UUID().uuidString,
//            senderId: senderId,
//            text: text,
//            timestamp: Date()
//        )
//        
//        let conversationRef = db.collection("conversations")
//            .document(conversationId)
//        
//        do {
//            try conversationRef
//                .collection("messages")
//                .document(message.id ?? UUID().uuidString)
//                .setData(from: message)
//            
//            conversationRef.updateData([
//                "lastMessage": text,
//                "timestamp": Date()
//            ])
//            
//        } catch {
//            print("Error sending message: \(error.localizedDescription)")
//        }
//    }
//    
//    // MARK: - Listen for Messages
//    func listenForMessages(conversationId: String,
//                           completion: @escaping ([Message]) -> Void) {
//        
//        db.collection("conversations")
//            .document(conversationId)
//            .collection("messages")
//            .order(by: "timestamp")
//            .addSnapshotListener { snapshot, error in
//                
//                if let error = error {
//                    print("Listen error: \(error.localizedDescription)")
//                    completion([])
//                    return
//                }
//                
//                let messages = snapshot?.documents.compactMap {
//                    try? $0.data(as: Message.self)
//                } ?? []
//                
//                completion(messages)
//            }
//    }
//    
//    // MARK: - Fetch Conversations for User
//    func fetchConversations(for userId: String,
//                            completion: @escaping ([Conversation]) -> Void) {
//        
//        db.collection("conversations")
//            .whereField("participants", arrayContains: userId)
//            .order(by: "timestamp", descending: true)
//            .getDocuments { snapshot, error in
//                
//                if let error = error {
//                    print("Fetch conversations error: \(error.localizedDescription)")
//                    completion([]) // return empty array on error
//                    return
//                }
//                
//                Task { @MainActor in
//                    // safely unwrap optional snapshot
//                    let conversations = (try? snapshot?.documents.map {
//                        try $0.data(as: Conversation.self)
//                    }) ?? [] // <- if snapshot is nil, return empty array
//                    
//                    completion(conversations) // now guaranteed [Conversation]
//                }
//            }
//    }
//
//}
