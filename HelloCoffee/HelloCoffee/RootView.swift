//
//  RootView.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import SwiftUI
import AccessibilityIds

struct RootView: View {
    
    @EnvironmentObject private var model: CoffeeModel
    
    @State private var isNewOrderViewPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if model.orders.isEmpty {
                    Text("No orders available!")
                        .setAccessiblityId(screen: Root.self, .noOrdersText)
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
                    .setAccessiblityId(screen: Root.self, .buttonToAddNewOrder)
                }
            }
            .sheet(isPresented: $isNewOrderViewPresented) {
                AddCoffeeView()
            }
        }
    }
}

//MARK: - Functions
private extension RootView {
    func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            print(error)
        }
    }
}

//MARK: - Preview
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        RootView()
            .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
