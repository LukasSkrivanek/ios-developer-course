//
//  MockDataProvider.swift
//  Course App
//
//  Created by macbook on 17.05.2024.
//

import UIKit

let mockImages = [
    UIImage.nature,
    UIImage.computer,
    UIImage.food
]

struct SectionData: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var jokes: [Joke]
}

struct Joke: Identifiable, Hashable {
    let id = UUID()
    let text: String
    let image = mockImages.randomElement()
}

final class MockDataProvider: ObservableObject {
    @Published var data: [SectionData]
    // MARK: Data
    private var localData = [
        SectionData(title: "Celebrations", jokes: [
            Joke(text: "Why don't eggs tell jokes? They'd crack up."),
            Joke(text: "What do you call a bear with no teeth? A gummy bear."),
            Joke(text: "Why did the bicycle fall over? It was two-tired.")
        ])
    ]
    init() {
        data = localData
      // updateData()
    }
}

// MARK: - Private methods
private extension MockDataProvider {
    func  updateData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            if var section = self.localData.first {
                section.jokes.remove(at: 1)
                self.data = [section]
            }
        })
    }
}
