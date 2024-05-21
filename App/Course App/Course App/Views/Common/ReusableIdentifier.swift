//
//  ReusableIdentifier.swift
//  Course App
//
//  Created by macbook on 18.05.2024.
//

import UIKit

protocol ReusableIdentifier {
    static var identifier: String { get }
}

extension ReusableIdentifier where Self: UICollectionViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}
