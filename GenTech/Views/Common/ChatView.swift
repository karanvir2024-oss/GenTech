//
//  ChatView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct ChatView: View {
    
    @State private var message = ""
    @State private var messages: [String] = []
    
    var body: some View {
        
        VStack {
            
            List(messages, id: \.self) { msg in
                Text(msg)
            }
            
            HStack {
                TextField("Type message...", text: $message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Send") {
                    messages.append(message)
                    message = ""
                }
            }
            .padding()
        }
        .navigationTitle("Chat")
       // .navigationBarBackButtonHidden(true)

    }
}
