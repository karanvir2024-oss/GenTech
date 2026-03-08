//
//  FirestoreService.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import Foundation
////import FirebaseFirestore
////import FirebaseFirestoreSwift
//
//class FirestoreService {
//    
//    static let shared = FirestoreService()
//    private let db = Firestore.firestore()
//    
//    func addProject(_ project: Project) throws {
//        try db.collection("projects")
//            .document(project.id)
//            .setData(from: project)
//    }
//    
//    func fetchProjects(for userId: String,
//                       completion: @escaping ([Project]) -> Void) {
//        
//        db.collection("projects")
//            .whereField("ownerId", isEqualTo: userId)
//            .getDocuments { snapshot, _ in
//                
//                let projects = snapshot?.documents.compactMap {
//                    try? $0.data(as: Project.self)
//                } ?? []
//                
//                completion(projects)
//            }
//    }
//    // MARK: - Fetch All Projects (For Investors)
//    func fetchAllProjects(completion: @escaping ([Project]) -> Void) {
//        
//        db.collection("projects")
//            .order(by: "createdAt", descending: true)
//            .getDocuments { snapshot, _ in
//                
//                let projects = snapshot?.documents.compactMap {
//                    try? $0.data(as: Project.self)
//                } ?? []
//                
//                completion(projects)
//            }
//    }
//
//}
