//
//  ProfileView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct ProfileView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @State private var showImagePicker = false
//    @State private var selectedImage: UIImage?
//    @State private var showPremiumSheet = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            // Profile Image Circle
//            Button {
//                showImagePicker = true
//            } label: {
//                if let image = authVM.profileImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 180, height: 180)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.blue, lineWidth: 3))
//                        .shadow(radius: 5)
//                } else {
//                    Circle()
//                        .fill(Color.gray.opacity(0.3))
//                        .frame(width: 180, height: 180)
//                        .overlay(Text("Tap to add").foregroundColor(.gray))
//                }
//            }
//            
//            Text(authVM.userName).font(.largeTitle).bold()
//            Text(authVM.userEmail).foregroundColor(.gray)
//            Text("Role: \(authVM.roleText)").foregroundColor(.blue)
//            Text("Credits: $\(String(format: "%.2f", authVM.credits))")
//                .font(.headline).foregroundColor(.green)
//            
//            Button("Buy Premium ($250)") { showPremiumSheet = true }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.blue)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//            
//            Button("Logout") { authVM.logout() }
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(12)
//            
//        }
//        .padding()
//        .navigationTitle("Profile")
//        
//        // Image Picker
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//                .onDisappear {
//                    if let img = selectedImage {
//                        Task { await authVM.uploadProfileImage(img) }
//                    }
//                }
//        }
//        
//        // Load profile image
//        .task { await authVM.loadProfileImage() }
//        
//        // Premium Sheet
//        .sheet(isPresented: $showPremiumSheet) {
//            PremiumSubscriptionView()
//                .environmentObject(authVM)
//        }
//    }
//}
//
//
//

//import SwiftUI
//
//struct ProfileView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @State private var showImagePicker = false
//    @State private var selectedImage: UIImage?
//    @State private var showPremiumSheet = false
//    
//    let size: CGFloat = 160
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                
//                //Profile Image Section
//                ZStack(alignment: .bottomTrailing) {
//                    
//                    Button {
//                        showImagePicker = true
//                    } label: {
//                        if let image = authVM.profileImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: size, height: size)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle()
//                                        .stroke(
//                                            LinearGradient(
//                                                colors: [.blue, .purple],
//                                                startPoint: .topLeading,
//                                                endPoint: .bottomTrailing
//                                            ),
//                                            lineWidth: 4                                        )
//                                )
//                                .shadow(radius: 10)
//                        } else {
//                            Circle()
//                                .fill(Color.gray.opacity(0.2))
//                                .frame(width: size, height: size)
//                                .overlay(
//                                    Text("Add Photo")
//                                        .foregroundColor(.gray)
//                                )
//                        }
//                    }
//                    
//                    //Camera Icon
//                    Image(systemName: "camera.fill")
//                        .foregroundColor(.white)
//                        .padding(8)
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                        .offset(x: -5, y: -5)
//                }
//                
//                // Name + Email
//                VStack(spacing: 6) {
//                    Text(authVM.userName)
//                        .font(.title)
//                        .fontWeight(.bold)
//                    
//                    Text(authVM.userEmail)
//                        .foregroundColor(.gray)
//                        .font(.subheadline)
//                }
//                
//                // Info Card
//                VStack(spacing: 15) {
//                    
//                    HStack {
//                        Text("Role")
//                        Spacer()
//                        Text(authVM.roleText)
//                            .foregroundColor(.blue)
//                    }
//                    
//                    Divider()
//                    
//                    HStack {
//                        Text("Credits")
//                        Spacer()
//                        Text("$\(String(format: "%.2f", authVM.credits))")
//                            .foregroundColor(.green)
//                            .fontWeight(.semibold)
//                    }
//                    
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
//                .padding(.horizontal)
//                
//                //Premium Button
//                Button {
//                    showPremiumSheet = true
//                } label: {
//                    Text("Upgrade to Premium")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(
//                            LinearGradient(
//                                colors: [.blue],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        )
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .shadow(radius: 5)
//                }
//                .padding(.horizontal)
//                
//                //Logout Button
//                Button {
//                    authVM.logout()
//                } label: {
//                    Text("Logout")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.red.opacity(0.9))
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                }
//                .padding(.horizontal)
//                
//            }
//            .padding(.top, 30)
//        }
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                VStack {
//                    Spacer().frame(height: 30) // 👈 pushes title down a bit
//                    Text("Profile")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .padding(.top, 20)
//                }
//            }
//        }
//        //Image Picker
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//                .onDisappear {
//                    if let img = selectedImage {
//                        Task { await authVM.uploadProfileImage(img) }
//                    }
//                }
//        }
//        
//        // Load profile image
//        .task { await authVM.loadProfileImage() }
//        
//        //Premium Sheet
//        .sheet(isPresented: $showPremiumSheet) {
//            PremiumSubscriptionView()
//                .environmentObject(authVM)
//        }
//    }
//}
//


//import SwiftUI
//
//struct ProfileView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    @State private var showImagePicker = false
//    @State private var selectedImage: UIImage?
//    @State private var showPremiumSheet = false
//    
//    let size: CGFloat = 160
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                
//                // Profile Image Section
//                ZStack(alignment: .bottomTrailing) {
//                    
//                    Button {
//                        showImagePicker = true
//                    } label: {
//                        if let image = authVM.profileImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .frame(width: size, height: size)
//                                .clipShape(Circle())
//                                .overlay(
//                                    Circle()
//                                        .stroke(
//                                            LinearGradient(
//                                                colors: [.blue, .purple],
//                                                startPoint: .topLeading,
//                                                endPoint: .bottomTrailing
//                                            ),
//                                            lineWidth: 4
//                                        )
//                                )
//                                .shadow(radius: 10)
//                        } else {
//                            Circle()
//                                .fill(Color.gray.opacity(0.2))
//                                .frame(width: size, height: size)
//                                .overlay(
//                                    Text("Add Photo")
//                                        .foregroundColor(.gray)
//                                )
//                        }
//                    }
//                    
//                    Image(systemName: "camera.fill")
//                        .foregroundColor(.white)
//                        .padding(8)
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                        .offset(x: -5, y: -5)
//                }
//                
//                // Name + Email
//                VStack(spacing: 6) {
//                    Text(authVM.userName)
//                        .font(.title)
//                        .fontWeight(.bold)
//                    
//                    Text(authVM.userEmail)
//                        .foregroundColor(.gray)
//                        .font(.subheadline)
//                }
//                
//                // 🔥 PLAN BADGE (NEW)
//                Text(authVM.userPlan.rawValue)
//                    .font(.caption.bold())
//                    .padding(.horizontal, 14)
//                    .padding(.vertical, 6)
//                    .background(
//                        RoundedRectangle(cornerRadius: 20)
//                            .fill(
//                                authVM.userPlan == .premium ? Color.purple :
//                                authVM.userPlan == .pro ? Color.blue :
//                                Color.gray
//                            )
//                    )
//                    .foregroundColor(.white)
//                
//                // Info Card
//                VStack(spacing: 15) {
//                    
//                    HStack {
//                        Text("Role")
//                        Spacer()
//                        Text(authVM.roleText)
//                            .foregroundColor(.blue)
//                    }
//                    
//                    Divider()
//                    
//                    HStack {
//                        Text("Credits")
//                        Spacer()
//                        Text("$\(String(format: "%.2f", authVM.credits))")
//                            .foregroundColor(.green)
//                            .fontWeight(.semibold)
//                    }
//                    
//                    // 🔥 PLAN INSIDE CARD (optional extra clarity)
//                    HStack {
//                        Text("Plan")
//                        Spacer()
//                        Text(authVM.userPlan.rawValue)
//                            .foregroundColor(.purple)
//                            .fontWeight(.semibold)
//                    }
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                .cornerRadius(15)
//                .padding(.horizontal)
//                
//                // Premium Button
//                Button {
//                    showPremiumSheet = true
//                } label: {
//                    Text("Upgrade to Premium")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(
//                            LinearGradient(
//                                colors: [.blue],
//                                startPoint: .leading,
//                                endPoint: .trailing
//                            )
//                        )
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .shadow(radius: 5)
//                }
//                .padding(.horizontal)
//                
//                // Logout Button
//                Button {
//                    authVM.logout()
//                } label: {
//                    Text("Logout")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.red.opacity(0.9))
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                }
//                .padding(.horizontal)
//            }
//            .padding(.top, 30)
//        }
//        .toolbar {
//            ToolbarItem(placement: .principal) {
//                Text("Profile")
//                    .font(.title2)
//                    .fontWeight(.bold)
//            }
//        }
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//                .onDisappear {
//                    if let img = selectedImage {
//                        Task { await authVM.uploadProfileImage(img) }
//                    }
//                }
//        }
//        .task { await authVM.loadProfileImage() }
//        .sheet(isPresented: $showPremiumSheet) {
//            PremiumSubscriptionView()
//                .environmentObject(authVM)
//        }
//    }
//}


import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showPremiumSheet = false
    
    let size: CGFloat = 160
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Profile Image Section
                ZStack(alignment: .bottomTrailing) {
                    
                    Button {
                        showImagePicker = true
                    } label: {
                        if let image = authVM.profileImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: size, height: size)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(
                                            LinearGradient(
                                                colors: [.blue, .purple],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            ),
                                            lineWidth: 4
                                        )
                                )
                                .shadow(radius: 10)
                        } else {
                            Circle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width: size, height: size)
                                .overlay(
                                    Text("Add Photo")
                                        .foregroundColor(.gray)
                                )
                        }
                    }
                    
                    Image(systemName: "camera.fill")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .offset(x: -5, y: -5)
                }
                
                VStack(spacing: 6) {
                    Text(authVM.userName)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(authVM.userEmail)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                Text(authVM.userPlan.rawValue)
                    .font(.caption.bold())
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                authVM.userPlan == .premium ? Color.purple :
                                authVM.userPlan == .pro ? Color.blue :
                                Color.gray
                            )
                    )
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    
                    HStack {
                        Text("Role")
                        Spacer()
                        Text(authVM.roleText)
                            .foregroundColor(.blue)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Credits")
                        Spacer()
                        Text("$\(String(format: "%.2f", authVM.credits))")
                            .foregroundColor(.green)
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Plan")
                        Spacer()
                        Text(authVM.userPlan.rawValue)
                            .foregroundColor(.purple)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Button {
                    showPremiumSheet = true
                } label: {
                    Text("Upgrade to Premium")
                        .fontWeight(.semibold)
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
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                Button {
                    authVM.logout()
                } label: {
                    Text("Logout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.top, 30)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Profile")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
                .onDisappear {
                    if let img = selectedImage {
                        Task { await authVM.uploadProfileImage(img) }
                    }
                }
        }
        .task { await authVM.loadProfileImage() }
        .sheet(isPresented: $showPremiumSheet) {
            PremiumSubscriptionView()
                .environmentObject(authVM)
        }
    }
}
