//
//  OrderRow.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import SwiftUI

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .bold()
                    .accessibilityIdentifier("orderNameText")
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .opacity(0.5)
                    .accessibilityIdentifier("coffeeNameAndSizeText")
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .accessibilityIdentifier("orderNameText")
        }
    }
}
