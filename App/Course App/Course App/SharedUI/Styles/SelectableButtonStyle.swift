//
//  SelectableButtonStyle.swift
//  Course App
//
//  Created by macbook on 20.05.2024.
//

import SwiftUI

struct SelectableButtonStyle: ButtonStyle {
    @Binding var isSelected: Bool
    var color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(color.opacity(0.5))
            .foregroundStyle(isSelected ? .red : .white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut, value: isSelected)
            .animation(.easeInOut, value: configuration.isPressed)
            .contentShape(Rectangle())
    }
}
