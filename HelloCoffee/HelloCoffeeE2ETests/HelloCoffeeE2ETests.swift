//
//  HelloCoffeeE2ETests.swift
//  HelloCoffeeE2ETests
//
//  Created by  Vladyslav Fil on 11.03.2023.
//

import XCTest

final class when_app_is_launched_with_no_orders: XCTestCase {

    func test_should_make_sure_no_orders_message_is_displayed() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
