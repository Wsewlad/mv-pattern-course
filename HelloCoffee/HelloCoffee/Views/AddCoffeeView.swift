//
//  AddCoffeeView.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import SwiftUI

struct AddCoffeeView: View {
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    
    @State private var errors = Errors()
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
                .accessibilityIdentifier("name")
            Text(errors.name)
                .font(.caption)
                .visible(errors.name.isNotEmpty)
                
            
            TextField("Coffee name", text: $coffeeName)
                .accessibilityIdentifier("coffeeName")
            Text(errors.coffeeName)
                .font(.caption)
                .visible(errors.coffeeName.isNotEmpty)
            
            TextField("Price", text: $price)
                .accessibilityIdentifier("price")
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
                    
                }
            }
            .centerHorizontaly()
            .accessibilityIdentifier("placeOrderButton")
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
