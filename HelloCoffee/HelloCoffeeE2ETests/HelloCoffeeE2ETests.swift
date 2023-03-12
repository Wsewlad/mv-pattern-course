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

final class when_adding_a_new_coffee_order: XCTestCase {
    private var app: XCUIApplication!
    
    // called before each test
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to place order screen
        app.buttons["addNewOrderButton"].tap()
        // fill out the textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("4.50")
        // place the order
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_in_list_successfully() throws {
        XCTAssertEqual("John", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$4.50", app.staticTexts["coffeePriceText"].label)
    }
    
    // called after each test
    override func tearDown() {
        clearOrders()
    }
}

func clearOrders() {
    Task {
        guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
        let (_, _) = try! await URLSession.shared.data(from: url)
    }
}
