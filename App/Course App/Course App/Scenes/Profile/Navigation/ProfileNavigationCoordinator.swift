//
//  ProfileNavigationCoordinator.swift
//  Course App
//
//  Created by macbook on 01.06.2024.
//
import UIKit
import SwiftUI

final class ProfileNavigationCoordinator: NSObject, NavigationControllerCoordinator {
    private(set) lazy var navigationController:
    UINavigationController = CustomNavigationController()
    var childCoordinators = [Coordinator]()
    func start() {
        navigationController.setViewControllers([makeProfile()],
            animated: false)
    }
}

private extension ProfileNavigationCoordinator {
    func makeProfile() -> UIViewController {
        UIHostingController(rootView: ProfileView())
    }
}
