//
//  UpdateOrderUITests.swift
//  HelloCoffeeE2ETests
//
//  Created by  Vladyslav Fil on 15.03.2023.
//

import XCTest
import AccessibilityIds

final class UpdateOrderUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        clearOrders()
        app.setLaunchArguments()
        app.launch()
    }
    
    func fillFiledsAndPlaceOrder() {
        // go to place order screen
        app.tryTapButton(Root.buttonToAddNewOrder)
        
        XCTAssertTrue(app.staticTexts["Add Coffee"].exists)
        
        app.tryEnterTextIntoTextField(AddCoffee.nameTextField, text: "John")
        app.tryEnterTextIntoTextField(AddCoffee.coffeeNameTextField, text: "Hot Coffee")
        app.tryEnterTextIntoTextField(AddCoffee.priceTextField, text: "4.50")

        app.tryTapButton(AddCoffee.buttonForPlaceOrder)
    }
    
    func checkPlacedOrderOnRootScreen() {
        XCTAssertEqual("John", app.textElementById(Root.orderNameText).label)
        XCTAssertEqual("Hot Coffee (Medium)", app.textElementById(Root.coffeeNameAndSizeText).label)
        XCTAssertEqual("$4.50", app.textElementById(Root.coffeePriceText).label)
    }
    
    func test_coffeeOrderUpdated() throws {
        fillFiledsAndPlaceOrder()
        checkPlacedOrderOnRootScreen()
       // go to order details
        app.tryTapElementWithTimeout(Root.buttonToOrderElement(0))
        // check order details
        XCTAssertTrue(app.elementById(OrderDetail.coffeeNameText).exists)
        // open update order modal
        app.tryTapButton(OrderDetail.buttonToUpdateOrder)
        
        // check update order modal opened
        XCTAssertTrue(app.staticTexts["Update Coffee"].exists)
        // update order
        app.tryEnterTextIntoTextField(AddCoffee.coffeeNameTextField, text: "Updated Coffee")
        app.tryEnterTextIntoTextField(AddCoffee.priceTextField, text: "5.70")
        // save updates
        app.tryTapButton(AddCoffee.buttonForPlaceOrder)
        
        // check updates on OrderDetails
        XCTAssertTrue(app.isWithTimeoutHittable(OrderDetail.coffeeNameText, timeout: 0.5))
        XCTAssertEqual("Updated Coffee", app.textElementById(OrderDetail.coffeeNameText).label)
        XCTAssertEqual("$5.70", app.textElementById(OrderDetail.coffeePriceText).label)
        // go back to Root
        app.buttons["Back"].tap()
        
        // check updates on Root
        XCTAssertTrue(app.isWithTimeoutHittable(Root.coffeeNameAndSizeText, timeout: 0.5))
        XCTAssertEqual("Updated Coffee (Medium)", app.textElementById(Root.coffeeNameAndSizeText).label)
        XCTAssertEqual("$5.70", app.textElementById(Root.coffeePriceText).label)
    }
    
    // called after each test
    override func tearDown() {
        clearOrders()
    }
}

