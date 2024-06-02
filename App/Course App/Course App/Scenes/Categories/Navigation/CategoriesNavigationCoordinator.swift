//
//  CategoriesCoordinator.swift
//  Course App
//
//  Created by macbook on 29.05.2024.
//

import UIKit

final class CategoriesNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) lazy var navigationController:
    UINavigationController = CustomNavigationController()
    var childCoordinators = [Coordinator]()
    func start() {
        navigationController.setViewControllers([makeCategoriesCard()],
            animated: false)
    }
}

private extension CategoriesNavigationCoordinator {
    func makeCategoriesCard() -> UIViewController {
        CategoriesViewController()
    }
}
