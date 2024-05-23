//
//  MainTabBarController.swift
//  Course App
//
//  Created by macbook on 21.05.2024.
//

import UIKit
import SwiftUI

struct MainTabView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        MainTabBarController()
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
         setupGlobalTabBarUI()
         setupLocalTabBar()
         setupTabBarControllers()
    }
}

// MARK: UI Setup
private extension MainTabBarController {
    func setupLocalTabBar() {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = .brown
        tabBar.tintColor = .white
    }
    func setupGlobalTabBarUI() {
        UITabBar.appearance().backgroundColor = .brown
        UITabBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.bold(with: FontSize.size28)]
    }
    func setupTabBarControllers() {
        viewControllers = [setupCategoriesView(), setupSwipingCardView()]
    }
    func setupCategoriesView() -> UIViewController {
        let categoriesNavigationController = UINavigationController(rootViewController: HomeViewController())
        categoriesNavigationController.tabBarItem = UITabBarItem(
            title: "Categories",
            image: UIImage(systemName: "list.dash.header.rectangle"),
            tag: 0)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .brown
        appearance.shadowImage = UIImage()
        categoriesNavigationController.navigationBar.standardAppearance = appearance
        categoriesNavigationController.navigationBar.compactAppearance = appearance
        categoriesNavigationController.navigationBar.scrollEdgeAppearance = appearance
        return categoriesNavigationController
    }
    func setupSwipingCardView() -> UIViewController {
        let swipingNavigationController  = UINavigationController(
            rootViewController: UIHostingController(rootView: SwipingView()))
        swipingNavigationController.tabBarItem = UITabBarItem(
            title: "Swiping",
            image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"),
            tag: 1)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .brown
        appearance.shadowImage = UIImage()
        swipingNavigationController.navigationBar.standardAppearance = appearance
        swipingNavigationController.navigationBar.compactAppearance = appearance
        swipingNavigationController.navigationBar.scrollEdgeAppearance = appearance
        return swipingNavigationController
    }
}
