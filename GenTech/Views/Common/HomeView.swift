//
//  HomeView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//
//struct HomeView: View {
//    var body: some View {
//        NavigationView {
//            
//            
//          //  ZStack {
//                VStack {
//                    
//                    
//                    Image("GenTech_logo")
//                        .resizable()
//                        .scaledToFit()
//                        .aspectRatio(contentMode: .fill)
//                    
//                        .ignoresSafeArea()
//                    .frame(width: 150, height: 150)
//                    .padding(.top, 40)
//
//
//                    
//                    Text("Welcome to Karanvir Singh")
//                        .font(.largeTitle)
//                        .bold()
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal)
//                    
//                    Spacer()
//                    
//                    // Login Button
//                    NavigationLink(destination: LoginView()
//                        .navigationBarBackButtonHidden(true)
//                    ) {
//                        Text("Login")
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .cornerRadius(12)
//                            .padding(.horizontal)
//                    }
//                    
//                    // Signup Button
//                    NavigationLink(destination: SignUpView()
//                        .navigationBarBackButtonHidden(true)
//                    ) {
//                        Text("Sign Up")
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.green)
//                            .cornerRadius(12)
//                            .padding(.horizontal)
//                    }
//                    
//                    Spacer()
//                }
//            }
//        }
//    }
//
////}
//
//// Preview 
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
//
//


import SwiftUI

struct HomeView: View {
    
    @State private var animateGradient = false
    @State private var logoFloat = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // 🔥 Animated Gradient Background
                LinearGradient(
                    colors: [.black, .indigo, .purple, .black],
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animateGradient)
                
                VStack(spacing: 30) {
                    
                    Spacer()
                    
                    // 🔥 Logo + Title
                    VStack(spacing: 12) {
                        
                        Image("GenTech_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .offset(y: logoFloat ? -10 : 10)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: logoFloat)
                        
                        Text("GenTech")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Where Investors Meet Innovation")
                            .foregroundColor(.white.opacity(0.7))
                            .font(.subheadline)
                    }
                    
                    Text("Welcome to Karanvir Singh")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // 🔘 Buttons
                    VStack(spacing: 18) {
                        
                        NavigationLink(destination:
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                        ) {
                            AnimatedButton(title: "Login", color: .blue)
                        }
                        .buttonStyle(PlainButtonStyle())   // ✅ FIXED TAP ISSUE
                        
                        NavigationLink(destination:
                            SignUpView()
                                .navigationBarBackButtonHidden(true)
                        ) {
                            AnimatedButton(title: "Sign Up", color: .green)
                        }
                        .buttonStyle(PlainButtonStyle())   // ✅ FIXED TAP ISSUE
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                animateGradient = true
                logoFloat = true
            }
        }
    }
}

// 🔘 Clean Button (no gestures, safe for NavigationLink)
struct AnimatedButton: View {
    
    var title: String
    var color: Color
    
    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(18)
            .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
            .contentShape(Rectangle()) // ensures full tap area works
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
