//
//  ChatView.swift
//  
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct ChatView: View {
    let userName: String
    @State private var message = ""

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hello! Interested in your startup.")
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            HStack {
                TextField("Message", text: $message)
                    .textFieldStyle(.roundedBorder)

                Button("Send") {
                    // Send message logic
                }
            }
            .padding()
        }
        .navigationTitle(userName)
    }
}
