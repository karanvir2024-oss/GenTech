//
//  ThemeManager.swift
//  GenTech
//
//  Created by Karanvir Singh on 2026-04-11.
//

import Foundation
import SwiftUI
import Combine   // ✅ REQUIRED

final class ThemeManager: ObservableObject {

    @Published var isDarkMode: Bool = false

    var colorScheme: ColorScheme? {
        isDarkMode ? .dark : .light
    }

    func toggleTheme() {
        isDarkMode.toggle()
    }
}
