//
//  NewPostView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import Foundation
//import Combine
//import FirebaseFirestore
//import FirebaseFirestore
//
//class EntrepreneurViewModel: ObservableObject {
//    
//    @Published var projects: [Project] = []
//    @Published var isLoading: Bool = false
//    
//    private let db = Firestore.firestore()
//    
//    // MARK: - Add Project
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
//            timestamp: Date()
//        )
//        
//        do {
//            try db.collection("projects")
//                .document(project.id ?? UUID().uuidString)
//                .setData(from: project)
//        } catch {
//            print("Error adding project: \(error.localizedDescription)")
//        }
//    }
//    
//    // MARK: - Load My Projects
//    func loadProjects(for ownerId: String) {
//        isLoading = true
//        
//        db.collection("projects")
//            .whereField("ownerId", isEqualTo: ownerId)
//            .order(by: "timestamp", descending: true)
//            .getDocuments { snapshot, error in
//                
//                Task { @MainActor in
//                    self.isLoading = false
//                    
//                    if let error = error {
//                        print("Error fetching projects: \(error.localizedDescription)")
//                        self.projects = []
//                        return
//                    }
//                    
//                    self.projects = (try? snapshot?.documents.map {
//                        try $0.data(as: Project.self)
//                    }) ?? []
//                }
//            }
//    }
//}
