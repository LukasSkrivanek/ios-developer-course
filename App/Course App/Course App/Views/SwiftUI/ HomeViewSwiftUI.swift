//
//   HomeViewSwiftUI.swift
//  Course App
//
//  Created by macbook on 20.05.2024.
//

import SwiftUI

struct HomeViewSwiftUI: View {
    @StateObject private var dataProvider = MockDataProvider()
    @State private var isSelected: Bool = true
    var body: some View {
        List {
            ForEach(dataProvider.data) { section in
                Section(header: Text(section.title)
                    .foregroundColor(.white)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                ) {
                    VStack {
                        ForEach(section.jokes) { joke in
                            if let uiImage = joke.image {
                                ZStack(alignment: .bottomLeading) {
                                    Image(uiImage: uiImage)
                                        .resizableBordered(cornerRadius: UIConstants.cornerRadius)
                                        .onTapGesture {
                                            print("Tapped joke \(joke)")
                                        }
                                    imagePanel
                                }
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .cornerRadius(UIConstants.cornerRadius)
                                    .onTapGesture {
                                        print("Tapped joke with no image \(joke)")
                                    }
                            }
                        }
                    }
                    .background(Color.bg)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                }
                .listRowInsets(EdgeInsets())
                .background(Color.bg)
            }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(Color.bg)
    }
    private var imagePanel: some View {
        HStack {
            Text("Text")
                .foregroundStyle(.white)
            Spacer()
            Button {
                print("tapped button")
            } label: {
                Image(systemName: "heart")
            }
        .buttonStyle(SelectableButtonStyle(isSelected: .constant(true), color: .gray))
        }
        .padding(5)
    }
}
