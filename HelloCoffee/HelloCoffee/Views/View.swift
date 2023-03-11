//
//  View.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 12.03.2023.
//

import SwiftUI

extension View  {
    func centerHorizontaly() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
}
