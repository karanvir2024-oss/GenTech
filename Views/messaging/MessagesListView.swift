//
//  MessagesListView.swift
//  
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct MessagesListView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Investor John") {
                    ChatView(userName: "Investor John")
                }
                NavigationLink("Startup Alpha") {
                    ChatView(userName: "Startup Alpha")
                }
            }
            .navigationTitle("Messages")
        }
    }
}
