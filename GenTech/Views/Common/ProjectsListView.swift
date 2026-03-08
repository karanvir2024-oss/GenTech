//
//  ProjectsListView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//



import SwiftUI

struct ProjectsListView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @StateObject var vm = ProjectViewModel()
    var filterOwnProjects: Bool = false

    @State private var showAddProject = false

    var body: some View {
        VStack {
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
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(vm.projects) { project in
                            NavigationLink(destination: ProjectDetailView(project: project)
                                            .environmentObject(authVM)) {
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
        .navigationTitle(filterOwnProjects ? "My Projects" : "Projects")
        .toolbar {
            if filterOwnProjects && !vm.projects.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddProject = true
                    } label: { Image(systemName: "plus") }
                }
            }
        }
        .sheet(isPresented: $showAddProject, onDismiss: {
            guard let role = authVM.userRole else { return }
            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
        }) {
            AddProjectView(vm: vm)
        }
        .onAppear {
            guard let role = authVM.userRole else { return }
            vm.fetchProjects(role: role, onlyOwn: filterOwnProjects)
        }
    }
}
