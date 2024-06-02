//
//  AppCoordinator.swift
//  Course App
//
//  Created by macbook on 25.05.2024.
import UIKit

protocol AppCoordinating: ViewControllerCoordinator {}

final class AppCoordinator: AppCoordinating {
    private(set) lazy var rootViewController = makeTabBarFlow()

    var childCoordinators = [Coordinator]()
}

// MARK: - Start coordinator
extension AppCoordinator {
    func start() {
        setupAppUI()
    }
    func setupAppUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .white
        UITabBarItem.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.font: TextType.sectionTitle.uiFont
            ],
            for: .selected
        )
        UINavigationBar.appearance().tintColor = .white
    }

    func makeTabBarFlow() -> UIViewController {
        let coordinator = MainTabBarCoordinator()
        childCoordinators.append(coordinator)
        coordinator.start()
        return coordinator.rootViewController
    }
    func handleDeeplink(deeplink: DeepLink) {
        childCoordinators.forEach {$0.handleDeeplink(deeplink: deeplink)}
    }
}
