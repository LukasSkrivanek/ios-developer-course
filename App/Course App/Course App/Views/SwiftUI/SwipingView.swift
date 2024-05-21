//
//  SwipingView.swift
//  Course App
//
//  Created by macbook on 21.05.2024.
//

import SwiftUI

struct SwipingView: View {
    let dataProvider = MockDataProvider()
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    if let jokes = dataProvider.data.first?.jokes {
                        ZStack {
                            ForEach(jokes, id: \.self) { joke in
                                SwipingCard(configuration: SwipingCard.Configuration(
                                    image: Image(
                                        uiImage: joke.image!),
                                    title: "Category",
                                    description: joke.text),
                                            swipeStateAction: {print($0)})
                            }
                            .padding(.top, geometry.size.height  / 20)
                            .frame(width: geometry.size.width / 1.2, height: (geometry.size.width / 1.2) * 1.5)
                        }
                    } else {
                        Text("Empty data")
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
