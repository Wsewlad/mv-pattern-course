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

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CoffeeModel(webservice: Webservice()))
    }
}
