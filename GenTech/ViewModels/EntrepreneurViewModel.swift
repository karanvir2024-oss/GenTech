//
//  EntrepreneurViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//
//
//import Foundation
//
//class EntrepreneurViewModel: ObservableObject {
//    
//    @Published var projects: [Project] = []
//    
//    func addProject(title: String,
//                    description: String,
//                    funds: Double,
//                    ownerId: String) {
//        
//        let project = Project(
//            id: UUID().uuidString,
//            title: title,
//            description: description,
//            fundsNeeded: funds,
//            ownerId: ownerId,
//            createdAt: Date()
//        )
//        
//        try? FirestoreService.shared.addProject(project)
//    }
//    
//    func loadProjects(ownerId: String) {
//        FirestoreService.shared.fetchProjects(for: ownerId) { projects in
//            DispatchQueue.main.async {
//                self.projects = projects
//            }
//        }
//    }
//}
