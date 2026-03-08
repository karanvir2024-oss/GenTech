//
//  MyProjectsView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-23.
//

import SwiftUI

struct MyProjectsView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ProjectViewModel()

    var body: some View {
        NavigationView {
            ProjectsListView(filterOwnProjects: true)
                .environmentObject(authVM)
                .navigationTitle("My Projects")
        }
    }
}
