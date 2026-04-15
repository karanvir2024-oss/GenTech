//
//  ProjectsListView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//



//import SwiftUI
//
//struct ProjectsListView: View {
//
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject var vm = ProjectViewModel()
//    var filterOwnProjects: Bool = false
//
//    @State private var showAddProject = false
//
//    var body: some View {
//        VStack {
//            if filterOwnProjects && vm.projects.isEmpty {
//                Spacer()
//                VStack(spacing: 20) {
//                    Text("No projects yet")
//                        .font(.title2)
//                        .foregroundColor(.gray)
//
//                    Button("Add Project") {
//                        showAddProject = true
//                    }
//                    .font(.title2)
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(15)
//                }
//                Spacer()
//            } else {
//                ScrollView {
//                    LazyVStack(spacing: 20) {
//                        ForEach(vm.projects) { project in
//                            NavigationLink(destination: ProjectDetailView(project: project)
//                                            .environmentObject(authVM)) {
//                                                ProjectCardView(project: project)
//                                                .frame(height: 200)
//                                    .padding(.horizontal)
//                            }
//                        }
//                    }
//                    .padding(.vertical)
//                }
//            }
//        }
//        .navigationTitle(filterOwnProjects ? "My Projects" : "Projects")
//        .toolbar {
//            if filterOwnProjects && !vm.projects.isEmpty {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showAddProject = true
//                    } label: { Image(systemName: "plus") }
//                }
//            }
//        }
//        .sheet(isPresented: $showAddProject, onDismiss: {
//            guard let role = authVM.userRole else { return }
//            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
//        }) {
//            // Pass currentRole to AddProjectView
//            if let role = authVM.userRole {
//                AddProjectView(vm: vm, currentRole: role)
//            }
//        }
//        .onAppear {
//            guard let role = authVM.userRole else { return }
//            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
//        }
//    }
//}
//
//
//
//
//
//
//


import SwiftUI

struct ProjectsListView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ProjectViewModel()
    var filterOwnProjects: Bool = false

    @State private var showAddProject = false
    @State private var searchText = ""

    // ✅ FILTERED PROJECTS
    var filteredProjects: [Project] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return vm.projects
        } else {
            return vm.projects.filter { project in
                project.title.localizedCaseInsensitiveContains(searchText) ||
                project.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        VStack {

            // ✅ EMPTY STATE (ONLY FOR OWN PROJECTS)
            if filterOwnProjects && vm.projects.isEmpty {
                Spacer()

                VStack(spacing: 20) {
                    Text("No projects yet")
                        .font(.title2)
                        .foregroundColor(.gray)

                    Button("Add Project") {
                        showAddProject = true
                    }
                    .font(.title2)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                }

                Spacer()

            } else {

                // ✅ LIST WITH SEARCH FILTER
                ScrollView {
                    LazyVStack(spacing: 20) {

                        if filteredProjects.isEmpty {
                            Text("No matching projects")
                                .foregroundColor(.gray)
                                .padding(.top, 40)
                        }

                        ForEach(filteredProjects) { project in
                            NavigationLink(
                                destination: ProjectDetailView(project: project)
                                    .environmentObject(authVM)
                            ) {
                                ProjectCardView(project: project)
                                    .frame(height: 200)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
       // .navigationTitle(filterOwnProjects ? "My Projects" : "Projects")

        // ✅ SEARCH BAR
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search projects..."
        )
//        .navigationBarTitleDisplayMode(.large)
//        .toolbar {
//            if filterOwnProjects && !vm.projects.isEmpty {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showAddProject = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(filterOwnProjects ? "My Projects" : "Projects")
                    .font(.title2)
                    .fontWeight(.bold)
            }

            if filterOwnProjects && !vm.projects.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddProject = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }

        .sheet(isPresented: $showAddProject, onDismiss: {
            guard let role = authVM.userRole else { return }
            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
        }) {
            if let role = authVM.userRole {
                AddProjectView(vm: vm, currentRole: role)
            }
        }

        .onAppear {
            guard let role = authVM.userRole else { return }
            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
        }
    }
}
