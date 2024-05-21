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
    let isUIKit = true
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

/*
@ViewBuilder
var homeView: some View {
    if isUIKit {
        HomeView()
    } else {
        //HomeViewSwiftUI()
    }
}
*/

struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeViewController {
        HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
    }
}
