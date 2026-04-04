//
//  AddProjectView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import SwiftUI

struct AddProjectView: View {

    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var fundNeeded: String = ""
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false

    @ObservedObject var vm: ProjectViewModel
    var currentRole: SignupRole

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    TextField("Project Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    TextField("Funds Needed", text: $fundNeeded)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text(selectedImage == nil ? "Select Image" : "Change Image")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        let fundDouble = Double(fundNeeded) ?? 0

                        vm.addProject(
                            title: title,
                            description: description,
                            fundNeeded: fundDouble,
                            image: selectedImage,
                            currentRole: currentRole
                        )

                        dismiss()
                    }) {
                        Text("Add Project")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 20)
            }
            .navigationTitle("Add Project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}


