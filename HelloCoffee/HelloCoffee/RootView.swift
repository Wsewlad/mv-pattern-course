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
                    List {
                        ForEach(model.orders) { order in
                            NavigationLink(value: order.id) {
                                OrderRow(order: order)
                            }
                            .setAccessiblityId(screen: Root.self, .buttonToOrderElement(model.orders.firstIndex(of: order) ?? 0))
                        }
                        .onDelete(perform: deleteOrder)
                    }
                }
            }
            .navigationDestination(for: Int.self) { orderId in
                OrderDetailView(orderId: orderId)
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
    
    func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else {
                return
            }
            Task {
                do {
                    try await model.deleteOrder(orderId)
                } catch {
                    print(error)
                }
            }
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
