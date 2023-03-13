//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import SwiftUI
import AccessibilityIds

struct AddCoffeeView: View {
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    @State private var errors = Errors()
    
    @EnvironmentObject private var model: CoffeeModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .setAccessiblityId(screen: AddCoffee.self, .nameTextField)
                Text(errors.name)
                    .font(.caption)
                    .visible(errors.name.isNotEmpty)
                
                TextField("Coffee name", text: $coffeeName)
                    .setAccessiblityId(screen: AddCoffee.self, .coffeeNameTextField)
                Text(errors.coffeeName)
                    .font(.caption)
                    .visible(errors.coffeeName.isNotEmpty)
                
                TextField("Price", text: $price)
                    .setAccessiblityId(screen: AddCoffee.self, .priceTextField)
                Text(errors.price)
                    .font(.caption)
                    .visible(errors.price.isNotEmpty)
                
                Picker("Select size", selection: $coffeeSize) {
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Place Order") {
                    if isValid {
                        Task {
                            await placeOrder()
                        }
                    }
                }
                .centerHorizontaly()
                .setAccessiblityId(screen: AddCoffee.self, .buttonForPlaceOrder)
            }
            .navigationTitle("Add Coffee")
        }
    }
}

//MARK: - Functions
private extension AddCoffeeView {
    func placeOrder() async {
        let order = Order(
            name: name,
            coffeeName: coffeeName,
            total: Double(price) ?? 0,
            size: coffeeSize
        )
        do {
            try await model.placeOrder(order)
            dismiss()
        } catch {
            print(error)
        }
    }
}

//MARK: - Errors
private extension AddCoffeeView {
    struct Errors {
        var name: String = ""
        var coffeeName: String = ""
        var price: String = ""
    }
    
    var isValid: Bool {
        
        withAnimation {
            errors = Errors()
            
            if name.isEmpty {
                errors.name = "Name cannot be empty!"
            }
            if coffeeName.isEmpty {
                errors.coffeeName = "Coffee name cannot be empty!"
            }
            if price.isEmpty {
                errors.price = "Price cannot be empty!"
            } else if !price.isNumeric {
                errors.price = "Price needs to be a number!"
            } else if price.isLessThan(1) {
                errors.price = "Price needs to be more than 0!"
            }
        }
        
        return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
    }
}

//MARK: - Preview
struct AddCoffeeView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeView()
    }
}
