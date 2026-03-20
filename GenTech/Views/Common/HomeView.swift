//
//  HomeView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            
            
          //  ZStack {
                VStack {
                    
                    
                    Image("GenTech_logo")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                    
                        .ignoresSafeArea()
                    .frame(width: 150, height: 150)
                    .padding(.top, 40)


                    
                    Text("Welcome to Karanvir Singh")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Login Button
                    NavigationLink(destination: LoginView()
                        .navigationBarBackButtonHidden(true)) {
                        Text("Login")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    
                    // Signup Button
                    NavigationLink(destination: SignUpView()
                        .navigationBarBackButtonHidden(true)) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
    }

//}

// Preview 
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

