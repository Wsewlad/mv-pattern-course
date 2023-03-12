//
//  HelloCoffeeE2ETests.swift
//  HelloCoffeeE2ETests
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import XCTest
import AccessibilityIds

final class RootUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        clearOrders()
        app.setLaunchArguments()
        app.launch()
    }
    
    func test_noOrdersPlaceholderDisplayed() throws {
        XCTAssertTrue(app.isWithTimeoutHittable(Root.noOrdersText, timeout: 0.2))
    }
}

func clearOrders() {
    Task {
        guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
        let (_, _) = try! await URLSession.shared.data(from: url)
    }
}
