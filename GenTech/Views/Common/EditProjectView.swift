//
//  EditProjectView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-07.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct EditProjectView: View {

    @Environment(\.dismiss) var dismiss

    var project: Project

    @State private var title: String
    @State private var description: String
    @State private var fundNeeded: String

    init(project: Project) {
        self.project = project
        _title = State(initialValue: project.title)
        _description = State(initialValue: project.description)
        _fundNeeded = State(initialValue: "\(project.fundsNeeded)")
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Funds Needed", text: $fundNeeded)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Update Project") {
                    updateProject()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)

                Spacer()
            }
            .padding()
            .navigationTitle("Edit Project")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    func updateProject() {
        let db = Firestore.firestore()

        db.collection("projects").document(project.id).updateData([
            "title": title,
            "description": description,
            "fundNeeded": Double(fundNeeded) ?? 0
        ]) { error in
            if let error = error {
                print("-----------Update failed:", error.localizedDescription)
            } else {
                print("---------Project updated---------")
            }
            dismiss()
        }
    }
}
