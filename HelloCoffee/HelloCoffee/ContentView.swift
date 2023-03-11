//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    var body: some View {
        VStack {
            List(model.orders) { order in
                OrderRow(order: order)
            }
            .task {
                await populateOrders()
            }
        }
    }
}

//MARK: - Functions
private extension ContentView {
    func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
}

//MARK: - OrderRow
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

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoffeeModel(webservice: Webservice()))
    }
}
