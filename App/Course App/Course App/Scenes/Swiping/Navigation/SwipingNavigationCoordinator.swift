//
//  SwipingNavigationCoordinator.swift
//  Course App
//
//  Created by macbook on 28.05.2024.
//

import UIKit
import SwiftUI

final class SwipingNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) lazy var navigationController:
    UINavigationController  = CustomNavigationController()
    var childCoordinators = [Coordinator]()
    func start() {
        navigationController.setViewControllers(
            [makeSwipingCard()]
            , animated: false)
    }
}

// MARK: - Factories
private extension SwipingNavigationCoordinator {
    func makeSwipingCard() -> UIViewController {
        UIHostingController(rootView: SwipingView())
    }
}
