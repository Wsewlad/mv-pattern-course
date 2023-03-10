//
//  Webservice.swift
//  MVVMExample
//
//  Created by Mohammad Azam on 9/18/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badRequest
    case decodingError
}

class Webservice {
    
    func getProducts() async throws -> [Product] {
        
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return products
    }
    
}
