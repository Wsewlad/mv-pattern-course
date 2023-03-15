//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 14.03.2023.
//

import SwiftUI
import AccessibilityIds

struct OrderDetailView: View {
    var orderId: Int
    
    @EnvironmentObject private var model: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    @State private var isEditOrderPresented: Bool = false
    
    var body: some View {
        VStack {
            if let order = model.orderById(orderId) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(order.coffeeName)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .setAccessiblityId(screen: OrderDetail.self, .coffeeNameText)
                    
                    Text(order.size.rawValue)
                        .opacity(0.5)
                        .setAccessiblityId(screen: OrderDetail.self, .coffeeSizeText)
                    
                    Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                        .setAccessiblityId(screen: OrderDetail.self, .coffeePriceText)
                    
                    HStack {
                        Spacer()
                        Button("Delete Order", role: .destructive) {
                            deleteOrder()
                        }
                        .setAccessiblityId(screen: OrderDetail.self, .buttonForDeleteOrder)
                        
                        Button("Edit Order") {
                            isEditOrderPresented = true
                        }
                        .setAccessiblityId(screen: OrderDetail.self, .buttonToUpdateOrder)
                        
                        Spacer()
                    }
                }
                .padding()
                .sheet(isPresented: $isEditOrderPresented) {
                    AddCoffeeView(order: order)
                }
            }
            
            Spacer()
        }
    }
}

//MARK: - Func
private extension OrderDetailView {
    func deleteOrder() {
        Task {
            do {
                try await model.deleteOrder(orderId)
                dismiss()
            } catch {
                print(error)
            }
        }
    }
}

//MARK: - Preview
struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var config = Configuration()
        OrderDetailView(orderId: 1)
            .environmentObject(CoffeeModel(webservice: Webservice(baseURL: config.environment.baseURL)))
    }
}
