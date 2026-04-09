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
//    @State private var messageText = ""
//
//    var body: some View {
//        VStack {
//            ScrollViewReader { scroll in
//                ScrollView {
//                    VStack(alignment: .leading, spacing: 10) {
//                        ForEach(vm.messages) { msg in
//                            HStack {
//                                if msg.senderId == authVM.currentUser?.id {
//                                    Spacer()
//                                    Text(msg.text)
//                                        .padding()
//                                        .background(Color.blue)
//                                        .foregroundColor(.white)
//                                        .cornerRadius(10)
//                                } else {
//                                    Text(msg.text)
//                                        .padding()
//                                        .background(Color.gray.opacity(0.2))
//                                        .cornerRadius(10)
//                                    Spacer()
//                                }
//                            }
//                        }
//                    }
//                    .padding()
//                    .onChange(of: vm.messages) { _ in
//                        if let last = vm.messages.last {
//                            withAnimation {
//                                scroll.scrollTo(last.id, anchor: .bottom)
//                            }
//                        }
//                    }
//                }
//            }
//
//            HStack {
//                TextField("Message...", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                Button("Send") {
//                    guard let senderId = authVM.currentUser?.id, !messageText.isEmpty else { return }
//                    vm.sendMessage(conversationId: conversationId, senderId: senderId, text: messageText)
//                    messageText = ""
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Chat K")
//        .onAppear {
//            vm.listenMessages(conversationId: conversationId)
//        }
//    }
//}
//


import SwiftUI

struct ChatView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ChatViewModel()

    var conversationId: String
    @State private var messageText = ""

    var body: some View {
        VStack {
            ScrollViewReader { scroll in
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(vm.messages) { msg in
                            HStack {
                                if msg.senderId == authVM.currentUser?.id {
                                    Spacer()
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                } else {
                                    Text(msg.text)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                    Spacer()
                                }
                            }
                            .id(msg.id) // Important for ScrollViewReader
                        }
                    }
                    .padding()
                    .onChange(of: vm.messages) { _ in
                        if let last = vm.messages.last {
                            withAnimation {
                                scroll.scrollTo(last.id, anchor: .bottom)
                            }
                        }
                    }
                }
            }

            HStack {
                TextField("Message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send") {
                    guard let senderId = authVM.currentUser?.id, !messageText.isEmpty else { return }
                    vm.sendMessage(conversationId: conversationId, senderId: senderId, text: messageText)
                    messageText = ""
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.listenMessages(conversationId: conversationId)
        }
    }
}

