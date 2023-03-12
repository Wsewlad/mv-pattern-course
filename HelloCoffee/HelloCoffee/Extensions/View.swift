//
//  View.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 12.03.2023.
//

import SwiftUI

//MARK: - Center Horizontaly
extension View {
    func centerHorizontaly() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}

//MARK: - Visible
extension View {
    @ViewBuilder
    func visible(_ value: Bool)-> some View {
        if value {
            self
        } else {
            EmptyView()
        }
    }
}
