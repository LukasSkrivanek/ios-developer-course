//
//  Course_AppApp.swift
//  Course App
//
//  Created by macbook on 26.04.2024.
//

import SwiftUI
import FirebaseCore

enum DeepLink {
    case onboarding(page: Int)
    case closeOnboarding
    case sigIn
}

// App delegate
final class AppDelegate: NSObject, UIApplicationDelegate {
    let appCoordinator: some AppCoordinating = {
        let coordinator = AppCoordinator()
        coordinator.start()
        return coordinator
    }()
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        deeplinkFromService()
        FirebaseApp.configure()
        return true
    }
    func deeplinkFromService() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {[weak self] in
            self?.appCoordinator.handleDeeplink(deeplink: .onboarding(page: 2))
        }
    }
}

@main
struct CourseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            CoordinatorView(coordinator: delegate.appCoordinator)
                .ignoresSafeArea(edges: .all)
        }
    }
}

struct HomeView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CategoriesViewController {
        CategoriesViewController()
    }

    func updateUIViewController(_ uiViewController: CategoriesViewController, context: Context) {
    }
}
