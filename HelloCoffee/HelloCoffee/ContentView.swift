//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    @State private var isNewOrderViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!")
                        .accessibilityIdentifier("noOrdersText")
                } else {
                    List(model.orders) { order in
                        OrderRow(order: order)
                    }
                }
            }
            .task {
                await populateOrders()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add new order") {
                        isNewOrderViewPresented = true
                    }
                    .accessibilityIdentifier("addNewOrderButton")
                }
            }
            .sheet(isPresented: $isNewOrderViewPresented) {
                AddCoffeeView()
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
        var config = Configuration()
        ContentView()
            .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
