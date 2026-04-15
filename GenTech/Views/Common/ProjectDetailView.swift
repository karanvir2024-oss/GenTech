//
//  ProjectDetailView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


//import SwiftUI
//
//struct ProjectDetailView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    var project: Project
//    
//    @State private var conversationId: String? = nil
//    @State private var showChat = false
//    
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                
//                Text(project.title)
//                    .font(.largeTitle)
//                    .bold()
//                
//                Text(project.description)
//                    .font(.body)
//                
//                Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//                
//                Spacer()
//                
//                // Show "Message Owner" button only if user is not the owner
//                if authVM.currentUser?.id != project.ownerId {
//                    Button(action: {
//                        guard let currentId = authVM.currentUser?.id else { return }
//                        
//                        // Create or fetch conversation
//                        ChatService.shared.createConversation(
//                            currentUserId: currentId,
//                            otherUserId: project.ownerId
//                        ) { id in
//                            DispatchQueue.main.async {
//                                self.conversationId = id
//                                self.showChat = true
//                            }
//                        }
//                    }) {
//                        Text("Message Owner")
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.blue)
//                            .cornerRadius(10)
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Project Details")
//        .navigationBarTitleDisplayMode(.inline)
//        // NavigationLink triggered programmatically
//        .background(
//            NavigationLink(
//                destination: Group {
//                    if let convoId = conversationId {
//                        ChatView(conversationId: convoId)
//                            .environmentObject(authVM)
//                    } else {
//                        EmptyView()
//                    }
//                },
//                isActive: $showChat,
//                label: { EmptyView() }
//            )
//        )    }
//}


//import SwiftUI
//
//struct ProjectDetailView: View {
//
//    @EnvironmentObject var authVM: AuthViewModel
//    var project: Project
//
//    @State private var goToChat = false
//    @State private var conversationId: String = ""
//    @State private var showEditSheet = false
//
//    var body: some View {
//        ScrollView {
//            
//            VStack(spacing: 0) {
//
//                //HEADER IMAGE
//                ZStack(alignment: .bottomLeading) {
//                    
//                    if !project.imageURL.isEmpty {
//                        AsyncImage(url: URL(string: project.imageURL)) { image in
//                            image
//                                .resizable()
//                                .scaledToFill()
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .frame(height: 250)
//                        .clipped()
//                    } else {
//                        Rectangle()
//                            .fill(
//                                LinearGradient(
//                                    colors: [.indigo, .purple],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                )
//                            )
//                            .frame(height: 250)
//                    }
//
//                    LinearGradient(
//                        colors: [.clear, .black.opacity(0.7)],
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//
//                    Text(project.title)
//                        .font(.largeTitle)
//                        .bold()
//                        .foregroundColor(.white)
//                        .padding()
//                }
//
//                VStack(alignment: .leading, spacing: 20) {
//
//                    //FUNDS CARD
//                    HStack {
//                        VStack(alignment: .leading) {
//                            Text("Funds Needed")
//                                .font(.caption)
//                                .foregroundColor(.gray)
//
//                            Text("$\(project.fundsNeeded, specifier: "%.2f")")
//                                .font(.title)
//                                .bold()
//                                .foregroundColor(.green)
//                        }
//
//                        Spacer()
//
//                        Image(systemName: "dollarsign.circle.fill")
//                            .font(.system(size: 40))
//                            .foregroundColor(.green)
//                    }
//                    .padding()
//                    .background(Color(.systemBackground))
//                    .cornerRadius(15)
//                    .shadow(radius: 3)
//
//                    //DESCRIPTION
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("About Project")
//                            .font(.headline)
//
//                        Text(project.description)
//                            .font(.body)
//                            .foregroundColor(.secondary)
//                    }
//                    .padding()
//                    .background(Color(.systemBackground))
//                    .cornerRadius(15)
//                    .shadow(radius: 3)
//
//                    //EDIT BUTTON (ONLY OWNER)
//                    if authVM.currentUser?.id == project.ownerId {
//                        Button {
//                            showEditSheet = true
//                        } label: {
//                            HStack {
//                                Image(systemName: "pencil")
//                                Text("Edit Project").bold()
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(15)
//                        }
//                    }
//
//                    //MESSAGE BUTTON (ONLY NON-OWNER)
//                    if authVM.currentUser?.id != project.ownerId {
//                        Button {
//                            guard let currentId = authVM.currentUser?.id else { return }
//
//                            ChatService.shared.createConversation(
//                                currentUserId: currentId,
//                                otherUserId: project.ownerId
//                            ) { convoId in
//
//                                DispatchQueue.main.async {
//                                    self.conversationId = convoId
//                                    self.goToChat = true
//                                }
//                            }
//
//                        } label: {
//                            HStack {
//                                Image(systemName: "message.fill")
//                                Text("Message Owner").bold()
//                            }
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(
//                                LinearGradient(
//                                    colors: [.blue, .purple],
//                                    startPoint: .leading,
//                                    endPoint: .trailing
//                                )
//                            )
//                            .foregroundColor(.white)
//                            .cornerRadius(15)
//                        }
//                    }
//
//                }
//                .padding()
//                .background(Color(.systemGroupedBackground))
//
//                //NAVIGATION TO CHAT
//                NavigationLink(
//                    destination: ChatView(
//                        conversationId: conversationId,
//                        senderName: "User" // ✅ temporary fallback
//                    )
//                    .environmentObject(authVM),
//                    isActive: $goToChat
//                ) {
//                    EmptyView()
//                }            }
//        }
//        .ignoresSafeArea(edges: .top)
//        .navigationBarTitleDisplayMode(.inline)
//
//        //EDIT SHEET
//        .sheet(isPresented: $showEditSheet) {
//            EditProjectView(project: project)
//        }
//    }
//}
//
//

import SwiftUI

struct ProjectDetailView: View {

    @EnvironmentObject var authVM: AuthViewModel
    var project: Project

    @State private var goToChat = false
    @State private var conversationId: String = ""
    @State private var showEditSheet = false

    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {

                // HEADER IMAGE
                ZStack(alignment: .bottomLeading) {
                    
                    if !project.imageURL.isEmpty {
                        AsyncImage(url: URL(string: project.imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 250)
                        .clipped()
                    } else {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [.indigo, .purple],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 250)
                    }

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.7)],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    Text(project.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                }

                VStack(alignment: .leading, spacing: 20) {

                    // FUNDS CARD
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Funds Needed")
                                .font(.caption)
                                .foregroundColor(.gray)

                            Text("$\(project.fundsNeeded, specifier: "%.2f")")
                                .font(.title)
                                .bold()
                                .foregroundColor(.green)
                        }

                        Spacer()

                        Image(systemName: "dollarsign.circle.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 3)

                    // DESCRIPTION
                    VStack(alignment: .leading, spacing: 10) {
                        Text("About Project")
                            .font(.headline)

                        Text(project.description)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(15)
                    .shadow(radius: 3)

                    // EDIT BUTTON (ONLY OWNER)
                    if authVM.currentUser?.id == project.ownerId {
                        Button {
                            showEditSheet = true
                        } label: {
                            HStack {
                                Image(systemName: "pencil")
                                Text("Edit Project").bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                    }

                    // MESSAGE BUTTON (ONLY NON-OWNER)
                    if authVM.currentUser?.id != project.ownerId {
                        Button {
                            guard let currentId = authVM.currentUser?.id else { return }

                            ChatService.shared.createConversation(
                                currentUserId: currentId,
                                otherUserId: project.ownerId,
                                otherUserName: "Project Owner" // ✅ FIXED
                            ) { convoId in

                                DispatchQueue.main.async {
                                    self.conversationId = convoId
                                    self.goToChat = true
                                }
                            }

                        } label: {
                            HStack {
                                Image(systemName: "message.fill")
                                Text("Message Owner").bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        }
                    }

                }
                .padding()
                .background(Color(.systemGroupedBackground))

                // NAVIGATION TO CHAT
                NavigationLink(
                    destination: ChatView(
                        conversationId: conversationId,
                        senderName: "Project Owner" // ✅ matches ChatView
                    )
                    .environmentObject(authVM),
                    isActive: $goToChat
                ) {
                    EmptyView()
                }
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarTitleDisplayMode(.inline)

        // EDIT SHEET
        .sheet(isPresented: $showEditSheet) {
            EditProjectView(project: project)
        }
    }
}
