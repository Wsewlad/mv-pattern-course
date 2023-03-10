//
//  Product.swift
//  HelloMV
//
//  Created by Mohammad Azam on 8/16/22.
//

import Foundation

struct Product: Decodable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
}
