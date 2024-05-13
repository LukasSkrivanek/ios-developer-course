//
//  Course_AppApp.swift
//  Course App
//
//  Created by macbook on 26.04.2024.
//

import SwiftUI
import FirebaseCore

@main
struct CourseApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
