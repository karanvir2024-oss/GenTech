//
//  AddProjectView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


import SwiftUI
import PhotosUI

struct AddProjectView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: ProjectViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var fundsNeeded = ""
    
    // Correct photo picker properties
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // MARK: Image Picker
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 200, height: 200)
                                .overlay(
                                    Text("Tap to add image")
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                    
                    VStack(spacing: 15) {
                        TextField("Project Title", text: $title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Project Description", text: $description)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        TextField("Funds Needed ($)", text: $fundsNeeded)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .navigationTitle("Add Project Pushed")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveProject()
                    }
                }
            }
        }
        //THIS loads the selected image
        .onChange(of: selectedItem) { newItem in
            loadImage(from: newItem)
        }
    }
    
    // this function will load the image properly
    private func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                selectedImage = uiImage
            }
        }
    }
    
    private func saveProject() {
        let funds = Double(fundsNeeded) ?? 0
        
        vm.addProject(
            title: title,
            description: description,
            fundNeeded: funds,
            image: selectedImage
        )
        
        dismiss()
    }
}
