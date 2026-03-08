//
//  ChatListView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct ChatListView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//    
//    var body: some View {
//        NavigationView {
//            List(vm.conversations) { conversation in
//                
//                NavigationLink(
//                    destination: ChatView(conversationId: conversation.id)
//                ) {
//                    VStack(alignment: .leading) {
//                        Text(conversation.lastMessage)
//                        Text(conversation.timestamp, style: .time)
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .navigationTitle("Chats")
//            .onAppear {
//                if let uid = authVM.currentUser?.id {
//                    vm.loadConversations(userId: uid)
//                }
//            }
//        }
//    }
//}
