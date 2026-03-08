//
//  InvestorDashboardView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct InvestorDashboardView: View {
//    
//    @StateObject var vm = InvestorViewModel()
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                
//                TextField("Search Projects", text: $vm.searchText)
//                    .textFieldStyle(.roundedBorder)
//                    .padding()
//                
//                ScrollView {
//                    LazyVStack(spacing: 15) {
//                        ForEach(vm.filteredProjects) { project in
//                            ProjectCardView(project: project)
//                        }
//                    }
//                    .padding()
//                }
//            }
//            .navigationTitle("Investor Dashboard")
//            .onAppear {
//                vm.loadProjects()
//            }
//        }
//    }
//}
