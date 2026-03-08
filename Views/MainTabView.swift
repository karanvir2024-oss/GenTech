//
//  MainTabView.swift
//  
//
//  Created by Karanvir Singh on 2026-02-02.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeFeedView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            MessagesListView()
                .tabItem {
                    Label("Messages", systemImage: "message.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
