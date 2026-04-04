//
//  SideMenuView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-22.
//


import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        List {
            NavigationLink("Profile") {
                ProfileView()
            }

            if authVM.userRole == .investor {
                NavigationLink("View Projects") {
                    ProjectsListView(filterOwnProjects: false)
                        .environmentObject(authVM)
                }

                NavigationLink("Home") {
                    InvestorMainView()
                }
            } else {
                // Entrepreneur → Only my projects
                NavigationLink("View Projects") {
                    ProjectsListView(filterOwnProjects: true)
                        .environmentObject(authVM)
                }

                // Other projects → all projects
                NavigationLink("Other Projects") {
                    ProjectsListView(filterOwnProjects: false)
                        .environmentObject(authVM)
                }

                NavigationLink("Home") {
                    EntrepreneurDashboard()
                }
            }

            NavigationLink("Chat") {
                ChatListView()
            }

            Button("Logout") {
                authVM.logout()
            }
            .foregroundColor(.red)
        }
        .navigationTitle("Menu")
        .navigationBarBackButtonHidden(true)

    }
}
