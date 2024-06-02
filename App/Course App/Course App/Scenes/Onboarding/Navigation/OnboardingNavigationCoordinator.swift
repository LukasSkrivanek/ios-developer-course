//
//  OnboardingNavigationCoordinator.swift
//  Course App
//
//  Created by macbook on 28.05.2024.
//

import UIKit
import SwiftUI
import Combine

protocol OnboardingCoordinating: NavigationControllerCoordinator {}

final class OnboardingNavigationCoordinator: OnboardingCoordinating {
    func start() {
        navigationController.setViewControllers(
            [makeOnboardingView(page: Page.firstPage)], animated: false
        )
    }
    deinit {
        print("Deinit OnboardingNavigationCoordinator")
    }
    private(set) lazy var navigationController: UINavigationController = makeNavigationController()
    private var cancellables = Set<AnyCancellable>()
    private let eventSubject = PassthroughSubject<OnboardingNavigationCoordinatorEvent, Never>()
    var childCoordinators = [Coordinator]()
}

extension OnboardingNavigationCoordinator {
    func makeNavigationController() -> UINavigationController {
        let navigationController = CustomNavigationController()
        navigationController.eventPublisher.sink { [weak self] _ in
            guard let self else {
                return
            }
            self.eventSubject.send(.dismiss(self))
        }
        .store(in: &cancellables)
        return navigationController
    }
    private func makeOnboardingView(page: Page) -> UIViewController {
        let onboardingView = OnboardingView(page: page.rawValue, title: page.title)
        onboardingView.eventPublisher.sink { [weak self] event in
            guard let self else {
                return
            }
            switch event {
            case .close:
                self.navigationController.dismiss(animated: true)
            case let .nextPage(from):
                var newPage = Page.firstPage
                if from < Page.allCases.count - 1 {
                    newPage = Page(rawValue: from + 1)!
                } else {
                    self.navigationController.dismiss(animated: true)
                }
                let viewController = self.makeOnboardingView(page: newPage)
                self.navigationController.pushViewController(viewController, animated: true)
            }
        }
        .store(in: &cancellables)
        return UIHostingController(rootView: onboardingView)
    }
}
    // MARK: - Event Emitting
    extension OnboardingNavigationCoordinator: EventEmitting {
        var eventPublisher: AnyPublisher<OnboardingNavigationCoordinatorEvent, Never> {
            eventSubject.eraseToAnyPublisher()
        }
    }
