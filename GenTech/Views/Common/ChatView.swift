//
//  ChatView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct ChatView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ChatViewModel()
//
//    var conversationId: String
//    var senderName: String
//
//    @State private var messageText = ""
//
//    var body: some View {
//
//        ZStack {
//
//            // 🔥 SAME BACKGROUND AS CHATLIST
//            LinearGradient(
//                colors: [.black, .indigo, .purple],
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea()
//
//            VStack {
//
//                // 💬 MESSAGES
//                ScrollViewReader { scroll in
//                    ScrollView {
//                        VStack(spacing: 10) {
//                            ForEach(vm.messages) { msg in
//                                HStack {
//
//                                    if msg.senderId == authVM.currentUser?.id {
//                                        Spacer()
//
//                                        Text(msg.text)
//                                            .padding()
//                                            .background(Color.blue)
//                                            .foregroundColor(.white)
//                                            .cornerRadius(12)
//                                            .frame(maxWidth: 250, alignment: .trailing)
//
//                                    } else {
//
//                                        Text(msg.text)
//                                            .padding()
//                                            .background(Color.white.opacity(0.15))
//                                            .foregroundColor(.white)
//                                            .cornerRadius(12)
//                                            .frame(maxWidth: 250, alignment: .leading)
//
//                                        Spacer()
//                                    }
//                                }
//                                .padding(.horizontal)
//                                .id(msg.id)
//                            }
//                        }
//                        .padding(.top)
//                        .onChange(of: vm.messages) { _ in
//                            if let last = vm.messages.last {
//                                withAnimation {
//                                    scroll.scrollTo(last.id, anchor: .bottom)
//                                }
//                            }
//                        }
//                    }
//                }
//
//                // ✏️ INPUT BAR
//                HStack {
//                    TextField("Message...", text: $messageText)
//                        .padding(10)
//                        .background(Color.white.opacity(0.15))
//                        .cornerRadius(10)
//                        .foregroundColor(.white)
//
//                    Button {
//                        guard let senderId = authVM.currentUser?.id,
//                              !messageText.isEmpty else { return }
//
//                        vm.sendMessage(
//                            conversationId: conversationId,
//                            senderId: senderId,
//                            text: messageText
//                        )
//
//                        messageText = ""
//
//                    } label: {
//                        Image(systemName: "paperplane.fill")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                }
//                .padding()
//            }
//        }
//
//        // ✅ TITLE
//        .navigationTitle(senderName)
//        .navigationBarTitleDisplayMode(.inline)
//       // .navigationBarBackButtonHidden(true)
//
//
//        .onAppear {
//            vm.listenMessages(conversationId: conversationId)
//        }
//    }
//}

import SwiftUI

struct ChatView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ChatViewModel()

    var conversationId: String
    var senderName: String

    @State private var messageText = ""

    var body: some View {
        
        VStack {
            
            // 💬 MESSAGES
            ScrollViewReader { scroll in
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading, spacing: 10) {
                        
                        ForEach(vm.messages) { msg in
                            
                            HStack {
                                
                                if msg.senderId == authVM.currentUser?.id {
                                    
                                    Spacer()
                                    
                                    Text(msg.text)
                                        .padding(10)
                                        .background(Color.blue.opacity(0.8))
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                } else {
                                    
                                    Text(msg.text)
                                        .padding(10)
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.primary)
                                        .cornerRadius(12)
                                    
                                    Spacer()
                                }
                            }
                            .id(msg.id)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                .onChange(of: vm.messages) { _ in
                    if let last = vm.messages.last {
                        withAnimation {
                            scroll.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // ✏️ INPUT BAR
            HStack {
                
                TextField("Message...", text: $messageText)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    guard let senderId = authVM.currentUser?.id,
                          !messageText.isEmpty else { return }

                    vm.sendMessage(
                        conversationId: conversationId,
                        senderId: senderId,
                        text: messageText
                    )

                    messageText = ""
                    
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.blue)
                        .padding(8)
                }
            }
            .padding()
        }
        .navigationTitle(senderName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.listenMessages(conversationId: conversationId)
        }
    }
}
