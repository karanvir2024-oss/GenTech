//
//  InvestorViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import Foundation
//import Combine
//
//class InvestorViewModel: ObservableObject {
//    
//    @Published var projects: [Project] = []
//    @Published var searchText: String = ""
//    
//    func loadProjects() {
//        FirestoreService.shared.fetchAllProjects { projects in
//            DispatchQueue.main.async {
//                self.projects = projects
//            }
//        }
//    }
//    
//    var filteredProjects: [Project] {
//        if searchText.isEmpty {
//            return projects
//        } else {
//            return projects.filter {
//                $0.title.lowercased().contains(searchText.lowercased())
//            }
//        }
//    }
//}
