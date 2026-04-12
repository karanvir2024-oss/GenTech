//
//  ChatListView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct ChatListView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(vm.conversations) { convo in
//                    if let convoId = convo.id {
//                        NavigationLink(
//                            destination: ChatView(conversationId: convoId)
//                                .environmentObject(authVM)
//                        ) {
//                            VStack(alignment: .leading) {
//                                Text(convo.lastMessage ?? "No messages yet")
//                                    .font(.body)
//                                Text(convo.timestamp, style: .time)
//                                    .font(.caption)
//                                    .foregroundColor(.gray)
//                            }
//                        }
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
//

//import SwiftUI
//
//struct ChatListView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//
//    var body: some View {
//        NavigationView {
//
//            ZStack {
//
//                // 🔥 BACKGROUND
//                LinearGradient(
//                    colors: [.black, .indigo, .purple],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                .ignoresSafeArea()
//
//                List {
//                    ForEach(vm.conversations) { convo in
//                        if let convoId = convo.id {
//
//                            NavigationLink(
//                                destination: ChatView(conversationId: convoId)
//                                    .environmentObject(authVM)
//                            ) {
//
//                                VStack(alignment: .leading, spacing: 2) {   // 🔥 reduced spacing
//
//                                    Text(convo.lastMessage ?? "No messages yet")
//                                        .font(.body)
//                                        .foregroundColor(.white)
//                                        .padding(10)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white.opacity(0.15))
//                                        .cornerRadius(12)
//
//                                    Text(convo.timestamp, style: .time)
//                                        .font(.caption2)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .padding(.leading, 4)
//                                }
//                                .padding(.vertical, 2)   // 🔥 reduced from 6 → 2
//                            }
//                            .listRowInsets(EdgeInsets()) // 🔥 removes default list padding
//                            .listRowBackground(Color.clear)
//                        }
//                    }
//                }
//                .scrollContentBackground(.hidden)
//                .background(Color.clear)
//            }
//
//            .navigationTitle("Chats")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.clear, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
//
//            .onAppear {
//                if let uid = authVM.currentUser?.id {
//                    vm.loadConversations(userId: uid)
//                }
//            }
//        }
//    }
//}
//
//


//import SwiftUI
//
//struct ChatListView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//
//    var body: some View {
//        NavigationView {
//
//            ZStack {
//
//                LinearGradient(
//                    colors: [.black, .indigo, .purple],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                .ignoresSafeArea()
//
//                List {
//                    ForEach(vm.conversations) { convo in
//                        if let convoId = convo.id {
//
//                            NavigationLink(
//                                destination: ChatView(conversationId: convoId)
//                                    .environmentObject(authVM)
//                            ) {
//
//                                VStack(alignment: .leading, spacing: 6) {
//
//                                    // ✅ CHANGED: show sender name instead of message
//                                    Text(convo.lastSenderName ?? "Unknown User")
//                                        .font(.body)
//                                        .foregroundColor(.white)
//                                        .padding()
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white.opacity(0.15))
//                                        .cornerRadius(12)
//
//                                    Text(convo.timestamp, style: .time)
//                                        .font(.caption)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .padding(.leading, 4)
//                                }
//                                .padding(.vertical, 6)
//                            }
//                            .listRowBackground(Color.clear)
//                        }
//                    }
//                }
//                .scrollContentBackground(.hidden)
//                .background(Color.clear)
//            }
//
//            .navigationTitle("Chats")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.clear, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
//
//            .onAppear {
//                if let uid = authVM.currentUser?.id {
//                    vm.loadConversations(userId: uid)
//                }
//            }
//        }
//    }
//}



//import SwiftUI
//
//struct ChatListView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//
//    var body: some View {
//        NavigationView {
//
//            ZStack {
//
//                // 🔥 BACKGROUND
//                LinearGradient(
//                    colors: [.black, .indigo, .purple],
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//                .ignoresSafeArea()
//
//                List {
//                    ForEach(vm.conversations) { convo in
//                        if let convoId = convo.id {
//
//                            NavigationLink(
//                                destination: ChatView(conversationId: convoId)
//                                    .environmentObject(authVM)
//                            ) {
//
//                                VStack(alignment: .leading, spacing: 2) {   // 🔥 reduced spacing
//
//                                    Text(convo.lastMessage ?? "No messages yet")
//                                        .font(.body)
//                                        .foregroundColor(.white)
//                                        .padding(10)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                        .background(Color.white.opacity(0.15))
//                                        .cornerRadius(12)
//
//                                    Text(convo.timestamp, style: .time)
//                                        .font(.caption2)
//                                        .foregroundColor(.white.opacity(0.6))
//                                        .padding(.leading, 4)
//                                }
//                                .padding(.vertical, 2)   // 🔥 reduced from 6 → 2
//                            }
//                            .listRowInsets(EdgeInsets()) // 🔥 removes default list padding
//                            .listRowBackground(Color.clear)
//                        }
//                    }
//                }
//                .scrollContentBackground(.hidden)
//                .background(Color.clear)
//            }
//
//            .navigationTitle("Chats")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color.clear, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
//
//            .onAppear {
//                if let uid = authVM.currentUser?.id {
//                    vm.loadConversations(userId: uid)
//                }
//            }
//        }
//    }
//}

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ChatViewModel()

    var body: some View {
        NavigationView {

            ZStack {

                // 🔥 BACKGROUND
                LinearGradient(
                    colors: [.black, .indigo, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                List {
                    ForEach(vm.conversations) { convo in
                        if let convoId = convo.id {

                            NavigationLink(
                                destination: ChatView(conversationId: convoId)
                                    .environmentObject(authVM)
                            ) {

                                VStack(alignment: .leading, spacing: 4) {

                                    // 👤 Sender Name
                                    Text(convo.senderName ?? "Unknown User")
                                        .font(.headline)
                                        .foregroundColor(.white.opacity(0.9))
                                        .padding(.horizontal, 10)
                                        .padding(.top, 8)

                                    // 💬 Last Message
                                    Text(convo.lastMessage ?? "No messages yet")
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.white.opacity(0.15))
                                        .cornerRadius(12)

                                    // ⏰ Timestamp
                                    Text(convo.timestamp, style: .time)
                                        .font(.caption2)
                                        .foregroundColor(.white.opacity(0.6))
                                        .padding(.leading, 4)
                                }
                                .padding(.vertical, 2)
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.clear)
            }

            .navigationTitle("Chats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.clear, for: .navigationBar)
            .toolbarBackground(.hidden, for: .navigationBar)

            .onAppear {
                if let uid = authVM.currentUser?.id {
                    vm.loadConversations(userId: uid)
                }
            }
        }
    }
}


