//
//  SignUpView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var contactNumber: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var signupRole: SignupRole = .investor
    
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            VStack(spacing: 15) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                TextField("Contact Number", text: $contactNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            VStack(spacing: 10) {
                Text("Select Role")
                    .font(.headline)
                
                Picker("Role", selection: $signupRole) {
                    Text("Investor").tag(SignupRole.investor)
                    Text("Entrepreneur").tag(SignupRole.entrepreneur)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            // Signup Button
            Button(action: {
                
                if firstName.isEmpty || lastName.isEmpty || contactNumber.isEmpty || email.isEmpty || password.isEmpty {
                    errorMessage = "Please fill in all fields"
                    return
                }
                
                errorMessage = ""
                
                Task {
                    await authVM.signUp(
                        firstName: firstName,
                        lastName: lastName,
                        contactNumber: contactNumber,
                        email: email,
                        password: password,
                        role: signupRole
                    )
                }
                
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            Spacer()
            
            // After successfull signup navigation
//            NavigationLink(
//                destination: authVM.userRole == .investor
//                    ? AnyView(InvestorMainView())
//                    : AnyView(EntrepreneurDashboard()),
//                isActive: $authVM.isLoggedIn,
//                label: { EmptyView() }
//            )
        }
        .padding(.top, 30)
        .onReceive(authVM.$errorMessage) { newValue in
            self.errorMessage = newValue
        }
    }
}

//import SwiftUI
//import Firebase
//import FirebaseStorage
//import FirebaseFirestore
//
//struct SignUpView: View {
//    
//    @EnvironmentObject var authVM: AuthViewModel
//    
//    @State private var firstName = ""
//    @State private var lastName = ""
//    @State private var email = ""
//    @State private var password = ""
//    @State private var contactNumber = ""
//    @State private var role: SignupRole = .investor
//    
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//    
//    @State private var isLoading = false
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            Button(action: { showImagePicker = true }) {
//                if let image = selectedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 100, height: 100)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
//                } else {
//                    Circle()
//                        .fill(Color.gray.opacity(0.5))
//                        .frame(width: 100, height: 100)
//                        .overlay(Text("Select\nPhoto").multilineTextAlignment(.center).foregroundColor(.white))
//                }
//            }
//            
//            TextField("First Name", text: $firstName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Last Name", text: $lastName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Email", text: $email)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            SecureField("Password", text: $password)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            TextField("Contact Number", text: $contactNumber)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            
//            Picker("Role", selection: $role) {
//                Text("Investor").tag(SignupRole.investor)
//                Text("Entrepreneur").tag(SignupRole.entrepreneur)
//            }.pickerStyle(SegmentedPickerStyle())
//            
//            Button("Sign Up") {
//                Task {
//                    await signUpUser()
//                }
//            }
//            .disabled(isLoading)
//        }
//        .padding()
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
//    }
//    
//    func signUpUser() async {
//        guard let image = selectedImage else { return } // Require image
//        isLoading = true
//        defer { isLoading = false }
//        
//        do {
//            // 1️⃣ Create user in Firebase Auth
//            let result = try await Auth.auth().createUser(withEmail: email, password: password)
//            let uid = result.user.uid
//            
//            // 2️⃣ Upload profile image to Firebase Storage
//            let storageRef = Storage.storage().reference().child("profileImages/\(uid).jpg")
//            if let imageData = image.jpegData(compressionQuality: 0.5) {
//                _ = try await storageRef.putDataAsync(imageData, metadata: nil)
//            }
//            let imageURL = try await storageRef.downloadURL()
//            
//            // 3️⃣ Save user data in Firestore
//            let db = Firestore.firestore()
//            try await db.collection("users").document(uid).setData([
//                "firstName": firstName,
//                "lastName": lastName,
//                "email": email,
//                "contactNumber": contactNumber,
//                "role": role.rawValue,
//                "credits": 0,
//                "isPremium": false,
//                "profileImageURL": imageURL.absoluteString
//            ])
//            
//            // 4️⃣ Update AuthViewModel
//            await authVM.fetchUser()
//            
//        } catch {
//            print("Sign Up Error: \(error.localizedDescription)")
//        }
//    }
//}
