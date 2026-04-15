//
//  HomeView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct HomeView: View {
    
    @State private var animateGradient = false
    @State private var logoFloat = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                //Animated Gradient Background
                LinearGradient(
                    colors: [.black, .indigo, .purple, .black],
                    startPoint: animateGradient ? .topLeading : .bottomTrailing,
                    endPoint: animateGradient ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: animateGradient)
                
                VStack(spacing: 30) {
                    
                    Spacer()
                    
                    //Logo + Title
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
                    
                    //Buttons
                    VStack(spacing: 18) {
                        
                        NavigationLink(destination:
                            LoginView()
                                .navigationBarBackButtonHidden(false) //allow back button
                        ) {
                            AnimatedButton(title: "Login", color: .blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination:
                            SignUpView()
                                .navigationBarBackButtonHidden(false)
                        ) {
                            AnimatedButton(title: "Sign Up", color: .green)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
            }
            //REMOVED toolbar hiding (this was killing back button)
            .onAppear {
                animateGradient = true
                logoFloat = true
            }
        }
    }
}

//Clean Button
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
            .contentShape(Rectangle())
    }
}

// Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
