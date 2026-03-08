//
//  EntrepreneurMainView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct EntrepreneurDashboard: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            ProjectsListView(filterOwnProjects: true)
                .environmentObject(authVM)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: SideMenuView()) {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                }
        }
    }
}

