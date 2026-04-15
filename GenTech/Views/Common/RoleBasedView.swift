//
//  RoleBasedView.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-02-22.
//

//import SwiftUI
//
//struct RoleBasedView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//
//    var body: some View {
//        Group {
//            if authVM.isLoggedIn {
//                if authVM.userRole == .investor {
//                    InvestorMainView()
//                } else {
//                    EntrepreneurDashboard()
//                }
//            } else {
//                if authVM.lastRole == .investor {
//                    InvestorMainView()
//                } else {
//                    EntrepreneurDashboard()
//                }
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        // Thias will show system back button
//        //.navigationBarTitle("Dashboard", displayMode: .inline)
//    }
//}
//

import SwiftUI

struct RoleBasedView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        contentView()
            .navigationBarBackButtonHidden(true)
    }

    // 🔥 Centralized logic (clean + safe)
    @ViewBuilder
    private func contentView() -> some View {
        
        let role = authVM.isLoggedIn
            ? authVM.userRole
            : authVM.lastRole
        
        if role == .investor {
            InvestorMainView()
        } else {
            EntrepreneurDashboard()
        }
    }
}
