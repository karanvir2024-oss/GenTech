
import Foundation
import FirebaseFirestore

class ChatService {
    static let shared = ChatService()
    private let db = Firestore.firestore()

    private init() {}

    // Create or get conversation
    func createConversation(currentUserId: String, otherUserId: String, completion: @escaping (String) -> Void) {
        let convoRef = db.collection("conversations")
            .whereField("participants", arrayContains: currentUserId)

        convoRef.getDocuments { snapshot, error in
            if let snapshot = snapshot {
                if let existing = snapshot.documents.first(where: { doc in
                    let participants = doc.data()["participants"] as? [String] ?? []
                    return participants.contains(otherUserId)
                }) {
                    completion(existing.documentID)
                    return
                }
            }

            // Create new conversation
            let newConvo = Conversation(participants: [currentUserId, otherUserId],
                                        lastMessage: "",
                                        timestamp: Date())
            do {
                let docRef = try self.db.collection("conversations").addDocument(from: newConvo)
                completion(docRef.documentID)
            } catch {
                print("Error creating convo: \(error)")
            }
        }
    }

    // Send message
    func sendMessage(conversationId: String, senderId: String, text: String) {
        let message = Message(senderId: senderId, text: text, timestamp: Date())
        do {
            _ = try db.collection("conversations")
                .document(conversationId)
                .collection("messages")
                .addDocument(from: message)

            db.collection("conversations").document(conversationId).updateData([
                "lastMessage": text,
                "timestamp": Date()
            ])
        } catch {
            print("Error sending message: \(error)")
        }
    }

    // Listen messages
    func listenMessages(conversationId: String, completion: @escaping ([Message]) -> Void) {
        db.collection("conversations")
            .document(conversationId)
            .collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                let msgs = documents.compactMap { try? $0.data(as: Message.self) }
                completion(msgs)
            }
    }

    // Fetch user conversations
    func fetchConversations(userId: String, completion: @escaping ([Conversation]) -> Void) {
        db.collection("conversations")
            .whereField("participants", arrayContains: userId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                let convos = documents.compactMap { try? $0.data(as: Conversation.self) }
                completion(convos)
            }
    }
}
