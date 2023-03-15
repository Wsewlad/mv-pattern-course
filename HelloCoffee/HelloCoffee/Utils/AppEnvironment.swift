//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    case deleteOrder(Int)
    case updateOrder(Int)
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        case let .deleteOrder(orderId):
            return "/test/orders/\(orderId)"
        case let .updateOrder(orderId):
            return "/test/orders/\(orderId)"
        }
    }
}

enum AppEnvironment: String {
    case dev
    case test
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "https://island-bramble.glitch.me")!
        case .test:
            return URL(string: "https://island-bramble.glitch.me")!
        }
    }
}

struct Configuration {
    lazy var environment: AppEnvironment = {
        // read value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else { return .dev }
        if env == "TEST" { return .test }
        return .dev
    }()
}
