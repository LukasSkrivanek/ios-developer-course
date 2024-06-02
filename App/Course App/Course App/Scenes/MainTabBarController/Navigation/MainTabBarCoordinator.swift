//
//  MainTabBarCoordinator.swift
//  Course App
//
//  Created by macbook on 23.05.2024.
//

import UIKit
import SwiftUI
import Combine

final class MainTabBarCoordinator: NSObject, TabBarControllerCoordinator {
    var childCoordinators = [Coordinator]()
    private(set) lazy var tabBarController = makeTabBarController()
    private lazy var cancellables = Set<AnyCancellable>()

}

// MARK: - Start coordinator
extension MainTabBarCoordinator {
    func start() {
        tabBarController.viewControllers = [
            setupCategoriesView(),
            setupSwipingCardView(),
            setupProfileView()
        ]
    }
    func handleDeeplink(deeplink: DeepLink) {
        switch deeplink {
        case let .onboarding(page):
            let coordinator = makeOnboardingFlow()
            startChildCoordinator(coordinator)
            tabBarController.present(coordinator.rootViewController, animated: true)
        default:
            break
        }
    }
}

// MARK: Factory methods
private extension MainTabBarCoordinator {
    func makeOnboardingFlow() -> ViewControllerCoordinator {
        let coordinator = OnboardingNavigationCoordinator()
        coordinator.eventPublisher
            .sink { [weak self] event in
                self?.handle(event: event)
            }
            .store(in: &cancellables)
        return coordinator
    }
    func handle(event: OnboardingNavigationCoordinatorEvent) {
        switch event {
        case let .dismiss(coordinator):
            release(coordinator: coordinator)
        }
    }
    func makeTabBarController() -> UITabBarController {
    let tabBarController = UITabBarController()
        tabBarController.delegate = self
        return tabBarController
    }
    func setupCategoriesView() -> UIViewController {
        let categoriesCoordinator = CategoriesNavigationCoordinator()
        startChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.dash.header.rectangle"),
            tag: 0)
        return categoriesCoordinator.rootViewController
    }
    func setupSwipingCardView() -> UIViewController {
        let swipingCoordinator = SwipingNavigationCoordinator()
        startChildCoordinator(swipingCoordinator)
        swipingCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Swiping",
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            tag: 1)
        return  swipingCoordinator.rootViewController
    }
    func setupProfileView() -> UIViewController {
        let profileCoordinator = ProfileNavigationCoordinator()
        startChildCoordinator(profileCoordinator)
        profileCoordinator.rootViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            tag: 2)
        return profileCoordinator.rootViewController
    }
}

extension MainTabBarCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController === tabBarController.viewControllers?.last {
             rootViewController.showInfoAlert(title: "Ups something is wrong..")
        }
    }
}

// MARK: - Alert for any View
extension UIViewController {
    func showInfoAlert(title: String, message: String? = nil, handler: (() -> Void)? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction  = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                handler?()
            }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
