//
//  AppRouter.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

//struct AppRouter: View {
//    @EnvironmentObject var authVM: AuthViewModel
//
//    var body: some View {
//        NavigationView {
//            Group {
//                if authVM.isLoggedIn {
//                    if authVM.userRole == .entrepreneur {
//                        EntrepreneurDashboard()
//                            .environmentObject(authVM)
//                    } else {
//                        InvestorMainView()
//                            .environmentObject(authVM)
//                    }
//                } else {
//                    HomeView()
//                        .environmentObject(authVM)
//                }
//            }
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//    }
//}

struct AppRouter: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            Group {
                if authVM.isLoggedIn {
                    if authVM.userRole == .entrepreneur {
                        EntrepreneurDashboard()
                            .environmentObject(authVM)
                    } else {
                        InvestorMainView()
                            .environmentObject(authVM)
                    }
                } else {
                    HomeView()
                        .environmentObject(authVM)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
