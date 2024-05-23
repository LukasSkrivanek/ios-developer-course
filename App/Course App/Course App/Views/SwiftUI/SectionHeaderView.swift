//
//  SectionHeaderView.swift
//  Course App
//
//  Created by macbook on 23.05.2024.
//
import SwiftUI

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        Text(title)
            .padding()
            .textTypeModifier(textType: .h2Title)
            .background(.bg)
    }
}
