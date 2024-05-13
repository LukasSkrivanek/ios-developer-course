//
//  ContentView.swift
//  Course App
//
//  Created by macbook on 26.04.2024.
//

import SwiftUI
import os

struct ContentView: View {
    private let logger = Logger(subsystem: "$(APP_BUNDLE_IDENTIFIER)", category: "ContentView")
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .font(.custom("Poppins-Regular", size: 24))
        }
        .onAppear {
            self.logViewAppearance()
        }
        .padding()
    }
    private func logViewAppearance() {
        logger.info("ContentView appeared")
    }
}

#Preview {
    ContentView()
}
