//
//  ContentView.swift
//  HelloMV
//
//  Created by Mohammad Azam on 8/16/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var store: Store
    
    private func populateProducts() async {
        do {
           try await store.loadProducts(url: Constants.allProductsURL)
        } catch {
            print(error)
        }
    }
    
    var body: some View {
        List(store.products) { product in
            Text(product.title)
        }.task {
            await populateProducts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
