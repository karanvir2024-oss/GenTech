//
//  ChatListView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct ChatListView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ChatViewModel()

    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(vm.conversations) { convo in
                    
                    if let convoId = convo.id {
                        
                        NavigationLink {
                            ChatView(
                                conversationId: convoId,
                                senderName: convo.senderName ?? "Unknown User"
                            )
                            .environmentObject(authVM)
                        } label: {
                            
                            VStack(alignment: .leading, spacing: 4) {
                                
                                //NAME
                                Text(convo.senderName ?? "Unknown User")
                                    .font(.headline)
                                
                                //LAST MESSAGE
                                Text(convo.lastMessage ?? "No messages yet")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                //TIME
                                Text(convo.timestamp, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
            .navigationTitle("Chats")
        }
        .onAppear {
            if let uid = authVM.currentUser?.id {
                vm.loadConversations(userId: uid)
            }
        }
    }
}
