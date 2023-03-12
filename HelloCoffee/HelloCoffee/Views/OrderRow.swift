//
//  OrderRow.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import SwiftUI
import AccessibilityIds

struct OrderRow: View {
    let order: Order
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(order.name)
                    .bold()
                    .setAccessiblityId(screen: Root.self, .orderNameText)
                    
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .opacity(0.5)
                    .setAccessiblityId(screen: Root.self, .coffeeNameAndSizeText)
            }
            Spacer()
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .setAccessiblityId(screen: Root.self, .coffeePriceText)
        }
    }
}
