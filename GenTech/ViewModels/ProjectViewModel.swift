//
//  ProjectViewModel.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

@MainActor
class ProjectViewModel: ObservableObject {

    @Published var projects: [Project] = []

    private let db = Firestore.firestore()

    // Fetch Projects
    func fetchProjects(role: SignupRole, onlyOwn: Bool = false) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        var query: Query = db.collection("projects")
            .order(by: "timestamp", descending: true)

        if role == .entrepreneur && onlyOwn {
            query = query.whereField("ownerId", isEqualTo: uid)
        }

        query.getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching projects: \(error.localizedDescription)")
                return
            }

            Task { @MainActor in
                self.projects = snapshot?.documents.compactMap {
                    Project(
                        id: $0.documentID,
                        title: $0["title"] as? String ?? "",
                        description: $0["description"] as? String ?? "",
                        ownerId: $0["ownerId"] as? String ?? "",
                        fundsNeeded: $0["fundNeeded"] as? Double ?? 0.0,
                        imageURL: $0["imageURL"] as? String
                    )
                } ?? []
            }
        }
    }

    // Add Project
    func addProject(title: String,
                    description: String,
                    fundNeeded: Double = 0,
                    image: UIImage?,
                    currentRole: SignupRole) {

        guard let uid = Auth.auth().currentUser?.uid else { return }

        if let image = image {
            uploadImage(image) { imageURL in
                self.saveProject(
                    title: title,
                    description: description,
                    fundNeeded: fundNeeded,
                    ownerId: uid,
                    imageURL: imageURL
                ) {
                    self.fetchProjects(role: currentRole, onlyOwn: true)
                }
            }
        } else {
            saveProject(
                title: title,
                description: description,
                fundNeeded: fundNeeded,
                ownerId: uid,
                imageURL: nil
            ) {
                self.fetchProjects(role: currentRole, onlyOwn: true)
            }
        }
    }

    // Upload Image
    private func uploadImage(_ image: UIImage,
                             completion: @escaping (String?) -> Void) {

        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("project_images/\(UUID().uuidString).jpg")

        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completion(nil)
            return
        }

        imageRef.putData(imageData, metadata: nil) { _, error in
            if error != nil {
                completion(nil)
                return
            }

            imageRef.downloadURL { url, _ in
                completion(url?.absoluteString)
            }
        }
    }

    // Save Project
    private func saveProject(title: String,
                             description: String,
                             fundNeeded: Double,
                             ownerId: String,
                             imageURL: String?,
                             completion: @escaping () -> Void) {

        let data: [String: Any] = [
            "title": title,
            "description": description,
            "ownerId": ownerId,
            "fundNeeded": fundNeeded,
            "imageURL": imageURL ?? "",
            "timestamp": Date()
        ]

        db.collection("projects").addDocument(data: data) { error in
            if let error = error {
                print("Error saving project: \(error.localizedDescription)")
            }
            completion()
        }
    }
}


