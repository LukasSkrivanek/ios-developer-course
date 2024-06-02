//
//  Onboarding.swift
//  Course App
//
//  Created by macbook on 28.05.2024.
//

import SwiftUI
import Combine

struct OnboardingView: View {
    let page: Int
    let title: String
    private let eventSubject = PassthroughSubject<OnboardingViewEvent, Never>()
    init(page: Int, title: String) {
        self.page = page
        self.title = title
    }
    var body: some View {
        Text("Page \(title)")
        Button(page == Page.allCases.count - 1 ? "Close" : "Next Page") {
            if page == Page.allCases.count - 1 {
                eventSubject.send(.close)
            } else {
                eventSubject.send(.nextPage(from: page))
            }
        }
    }
}

// MARK: - Event emitter
extension OnboardingView: EventEmitting {
    var eventPublisher: AnyPublisher<OnboardingViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
}

enum OnboardingViewEvent {
    case nextPage(from: Int)
    case close
}
