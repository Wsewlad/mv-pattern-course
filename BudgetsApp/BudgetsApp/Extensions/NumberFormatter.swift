//
//  NumberFormatter.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
