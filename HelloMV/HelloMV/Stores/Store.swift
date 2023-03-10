//
//  Store.swift
//  HelloMV
//
//  Created by Mohammad Azam on 8/16/22.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
}

@MainActor
class Store: ObservableObject {
    
    @Published var products: [Product] = []
    
    func loadProducts(url: URL) async throws {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidRequest
        }
        
        self.products = try JSONDecoder().decode([Product].self, from: data)
    }
    
}
