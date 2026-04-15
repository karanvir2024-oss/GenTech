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
            
            ZStack {
                
                //SAME BACKGROUND AS LOGIN
                LinearGradient(
                    colors: [.black, .indigo, .purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

                        //GLASS CARD CONTAINER
                        VStack(spacing: 16) {

                            TextField("Project Title", text: $title)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .placeholderStyle()

                            TextField("Description", text: $description)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .placeholderStyle()

                            TextField("Funds Needed", text: $fundNeeded)
                                .keyboardType(.decimalPad)
                                .padding()
                                .background(Color.white.opacity(0.15))
                                .cornerRadius(12)
                                .foregroundColor(.white)
                                .placeholderStyle()

                            Button(action: {
                                showImagePicker = true
                            }) {
                                Text(selectedImage == nil ? "Select Image" : "Change Image")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        LinearGradient(
                                            colors: [.blue],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }

                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 150)
                                    .cornerRadius(12)
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
                                    .background(
                                        LinearGradient(
                                            colors: [.green],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                        .padding()
                        .background(.ultraThinMaterial) //glass effect
                        .cornerRadius(20)
                        .padding(.horizontal)

                        Spacer()
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Add Project")
            .navigationBarTitleDisplayMode(.inline)
            
            //BACK BUTTON (arrow only)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
        }
    }
}


