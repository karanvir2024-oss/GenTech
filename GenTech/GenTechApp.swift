//
//  GenTechApp.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

//import SwiftUI
//import Firebase
//
//@main
//struct GenTechApp: App {
//    
//    @StateObject var authVM = AuthViewModel() 
//    
//    init() {
//        FirebaseApp.configure()
//    }
//    
//    var body: some Scene {
//        WindowGroup {
//            HomeView()
//                .environmentObject(authVM)
//        }
//    }
//}

import SwiftUI
import Firebase

@main
struct GenTechApp: App {
    
    @StateObject var authVM = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppRouter() // ✅ THIS IS THE FIX
                .environmentObject(authVM)
        }
    }
}
