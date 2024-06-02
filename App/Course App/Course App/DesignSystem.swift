//
//  DesignSystem.swift
//  Course App
//
// Created by macbook on 22.05.2024.
import UIKit
import SwiftUI

enum FontSize: CGFloat {
    case size28 = 28
    case size22 = 22
    case size18 = 18
    case size12 = 12
}

enum FontType: String {
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
    case mediumItalic = "Poppins-MediumItalic"
}

enum TextType {
    case navigationTitle
    case sectionTitle
    case baseText
    case caption
}

// MARK: - TextType attributes SwiftUI
extension TextType {
    var font: Font {
        switch self {
        case .navigationTitle:
            .bold(with: .size28)
        case .caption:
            .regular(with: .size12)
        case .baseText:
            .regular(with: .size18)
        case .sectionTitle:
            .mediumItalic(with: .size22)
        }
    }

    var color: Color {
        .white
    }
}

// MARK: - TextType attributes UIKit
extension TextType {
    var uiFont: UIFont {
        switch self {
        case .navigationTitle:
            .bold(with: .size28)
        case .caption:
            .regular(with: .size12)
        case .baseText:
            .regular(with: .size18)
        case .sectionTitle:
            .mediumItalic(with: .size22)
        }
    }

    var uiColor: UIColor {
        .white
    }
}

extension UIFont {
    static func regular(with size: FontSize) -> UIFont {
        UIFont(name: FontType.regular.rawValue, size: size.rawValue)!
    }

    static func bold(with size: FontSize) -> UIFont {
        UIFont(name: FontType.bold.rawValue, size: size.rawValue)!
    }

    static func mediumItalic(with size: FontSize) -> UIFont {
        UIFont(name: FontType.mediumItalic.rawValue, size: size.rawValue)!
    }
}

extension Font {
    static func regular(with size: FontSize) -> Font {
        Font.custom(FontType.regular.rawValue, size: size.rawValue)
    }

    static func bold(with size: FontSize) -> Font {
        Font.custom(FontType.bold.rawValue, size: size.rawValue)
    }

    static func mediumItalic(with size: FontSize) -> Font {
        Font.custom(FontType.mediumItalic.rawValue, size: size.rawValue)
    }
}
