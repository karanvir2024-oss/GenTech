//
//  ProjectDetailView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//


//import SwiftUI
//
//struct ProjectDetailView: View {
//
//    @EnvironmentObject var authVM: AuthViewModel
//    var project: Project
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 20) {
//            Text(project.title)
//                .font(.largeTitle)
//                .bold()
//
//            Text(project.description)
//                .font(.body)
//
//          //  Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
//                .font(.headline)
//                .foregroundColor(.blue)
//
//            Spacer()
//
//            // Only show "Message Owner" if not the current user's project
//            if authVM.currentUser?.id != project.ownerId {
//                Button("Message Owner") {
//                    // implement chat logic
//                }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//            }
//        }
//        .padding()
//        .navigationTitle("Project Details")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

//import SwiftUI
//
//struct ProjectDetailView: View {
//
//    @EnvironmentObject var authVM: AuthViewModel
//    var project: Project
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//                Text(project.title)
//                    .font(.largeTitle)
//                    .bold()
//
//                Text(project.description)
//                    .font(.body)
//
//              //Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//
//                Spacer()
//
//                if authVM.currentUser?.id != project.ownerId {
//                    Button("Message Owner") {
//                        // implement chat logic
//                    }
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(12)
//                }
//            }
//            .padding()
//        }
//        .navigationTitle("Project Details")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}

import SwiftUI

struct ProjectDetailView: View {

    @EnvironmentObject var authVM: AuthViewModel
    var project: Project

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text(project.title)
                    .font(.largeTitle)
                    .bold()

                Text(project.description)
                    .font(.body)

                //Funds Needed now visible
                Text("Funds Needed: $\(project.fundsNeeded, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.blue)

                Spacer()

                if authVM.currentUser?.id != project.ownerId {
                    Button("Message Owner") {
                        
                        Text("Message owner messages you ")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Project Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
