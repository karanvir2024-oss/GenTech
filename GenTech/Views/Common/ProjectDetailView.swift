//
//  ProjectDetailView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import SwiftUI

struct ProjectDetailView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    var project: Project
    
    @State private var conversationId: String? = nil
    @State private var showChat = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(project.title)
                    .font(.largeTitle)
                    .bold()
                
                Text(project.description)
                    .font(.body)
                
                Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Spacer()
                
                // Show "Message Owner" button only if user is not the owner
                if authVM.currentUser?.id != project.ownerId {
                    Button(action: {
                        guard let currentId = authVM.currentUser?.id else { return }
                        
                        // Create or fetch conversation
                        ChatService.shared.createConversation(
                            currentUserId: currentId,
                            otherUserId: project.ownerId
                        ) { id in
                            DispatchQueue.main.async {
                                self.conversationId = id
                                self.showChat = true
                            }
                        }
                    }) {
                        Text("Message Owner")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Project Details")
        .navigationBarTitleDisplayMode(.inline)
        // NavigationLink triggered programmatically
        .background(
            NavigationLink(
                destination: Group {
                    if let convoId = conversationId {
                        ChatView(conversationId: convoId)
                            .environmentObject(authVM)
                    } else {
                        EmptyView()
                    }
                },
                isActive: $showChat,
                label: { EmptyView() }
            )
        )    }
}
