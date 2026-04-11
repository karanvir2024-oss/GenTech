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

