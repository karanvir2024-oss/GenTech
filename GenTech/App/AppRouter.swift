//
//  AppRouter.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-18.
//

import SwiftUI

struct AppRouter: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                if authVM.userRole == .entrepreneur {
                    EntrepreneurDashboard() // Own projects
                        .environmentObject(authVM)
                } else {
                    InvestorMainView() // Investor dashboard
                        .environmentObject(authVM)
                }
            } else {
                HomeView()
                    .environmentObject(authVM)
            }
        }
    }
}
