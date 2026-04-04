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
        NavigationView {
            List {
                ForEach(vm.conversations) { convo in
                    if let convoId = convo.id {
                        NavigationLink(
                            destination: ChatView(conversationId: convoId)
                                .environmentObject(authVM)
                        ) {
                            VStack(alignment: .leading) {
                                Text(convo.lastMessage ?? "No messages yet")
                                    .font(.body)
                                Text(convo.timestamp, style: .time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Chats")
            .onAppear {
                if let uid = authVM.currentUser?.id {
                    vm.loadConversations(userId: uid)
                }
            }
        }
    }
}

