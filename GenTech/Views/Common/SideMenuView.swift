//
//  SideMenuView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-22.
//


//import SwiftUI
//
//struct SideMenuView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//
//    var body: some View {
//        List {
//            NavigationLink("Profile") {
//                ProfileView()
//            }
//
//            if authVM.userRole == .investor {
//                NavigationLink("View Projects") {
//                    ProjectsListView(filterOwnProjects: false)
//                        .environmentObject(authVM)
//                }
//
//                NavigationLink("Home") {
//                    InvestorMainView()
//                }
//            } else {
//                // Entrepreneur → Only my projects
//                NavigationLink("View Projects") {
//                    ProjectsListView(filterOwnProjects: true)
//                        .environmentObject(authVM)
//                }
//
//                // Other projects → all projects
//                NavigationLink("Other Projects") {
//                    ProjectsListView(filterOwnProjects: false)
//                        .environmentObject(authVM)
//                }
//
//                NavigationLink("Home") {
//                    EntrepreneurDashboard()
//                }
//            }
//
//            NavigationLink("Chat") {
//                ChatListView()
//            }
//
//            Button("Logout") {
//                authVM.logout()
//            }
//            .foregroundColor(.red)
//        }
//        .navigationTitle("Menu")
//        .navigationBarBackButtonHidden(true)
//
//    }
//}


//import SwiftUI
//
//struct SideMenuView: View {
//
//    @EnvironmentObject var authVM: AuthViewModel
//    @EnvironmentObject var themeManager: ThemeManager
//
//    var body: some View {
//        List {
//
//            // MARK: - Profile
//            NavigationLink("Profile") {
//                ProfileView()
//            }
//
//            // MARK: - ROLE BASED NAVIGATION
//            if authVM.userRole == .investor {
//
//                NavigationLink("View Projects") {
//                    ProjectsListView(filterOwnProjects: false)
//                        .environmentObject(authVM)
//                }
//
//                NavigationLink("Home") {
//                    InvestorMainView()
//                }
//
//            } else {
//
//                NavigationLink("View Projects") {
//                    ProjectsListView(filterOwnProjects: true)
//                        .environmentObject(authVM)
//                }
//
//                NavigationLink("Other Projects") {
//                    ProjectsListView(filterOwnProjects: false)
//                        .environmentObject(authVM)
//                }
//
//                NavigationLink("Home") {
//                    EntrepreneurDashboard()
//                }
//            }
//
//            // MARK: - CHAT
//            NavigationLink("Chat") {
//                ChatListView()
//            }
//
//            // MARK: - THEME TOGGLE (BEFORE LOGOUT)
//            HStack {
//
////                Image(systemName: themeManager.isDarkMode ? "moon.fill" : "sun.max.fill")
////                    .foregroundColor(.blue)
//
//                Text("Dark Mode")
//
//                Spacer()
//
//                Toggle("", isOn: $themeManager.isDarkMode)
//                    .labelsHidden()
//            }
//            .padding(.vertical, 6)
//
//            // MARK: - LOGOUT
//            Button("Logout") {
//                authVM.logout()
//            }
//            .foregroundColor(.red)
//        }
//        .navigationTitle("Menu")
//        .navigationBarBackButtonHidden(true)
//    }
//}

import SwiftUI

struct SideMenuView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        
        NavigationStack {
            
            List {
                
                // 👤 PROFILE
                Section {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Label("Profile", systemImage: "person.fill")
                    }
                }
                
                // 💼 DASHBOARD / ROLE BASED
                Section {
                    
                    if authVM.userRole == .investor {
                        
                        NavigationLink {
                            ProjectsListView(filterOwnProjects: false)
                                .environmentObject(authVM)
                        } label: {
                            Label("View Projects", systemImage: "doc.text.magnifyingglass")
                        }
                        
                        NavigationLink {
                            InvestorMainView()
                        } label: {
                            Label("Home", systemImage: "house.fill")
                        }
                        
                    } else {
                        
                        NavigationLink {
                            ProjectsListView(filterOwnProjects: true)
                                .environmentObject(authVM)
                        } label: {
                            Label("My Projects", systemImage: "folder.fill")
                        }
                        
                        NavigationLink {
                            ProjectsListView(filterOwnProjects: false)
                                .environmentObject(authVM)
                        } label: {
                            Label("Explore Projects", systemImage: "globe")
                        }
                        
                        NavigationLink {
                            EntrepreneurDashboard()
                        } label: {
                            Label("Home", systemImage: "house.fill")
                        }
                    }
                }
                
                // 💬 CHAT
                Section {
                    NavigationLink {
                        ChatListView()
                    } label: {
                        Label("Chat", systemImage: "message.fill")
                    }
                }
                
                // 🎨 DARK MODE TOGGLE
                Section {
                    Toggle(isOn: $themeManager.isDarkMode) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }
                
                // 🚪 LOGOUT
                Section {
                    Button {
                        authVM.logout()
                    } label: {
                        Label("Logout", systemImage: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
