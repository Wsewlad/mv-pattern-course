//
//  DeleteOrderUITests.swift
//  HelloCoffeeE2ETests
//
//  Created by  Vladyslav Fil on 13.03.2023.
//

import XCTest
import AccessibilityIds

final class DeleteOrderUITests: XCTestCase {
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
        
        app.tryEnterTextIntoTextField(AddCoffee.nameTextField, text: "John")
        app.tryEnterTextIntoTextField(AddCoffee.coffeeNameTextField, text: "Hot Coffee")
        app.tryEnterTextIntoTextField(AddCoffee.priceTextField, text: "4.50")

        app.tryTapButton(AddCoffee.buttonForPlaceOrder)
    }
    
    func test_deleteOrder() throws {
        fillFiledsAndPlaceOrder()
        
        XCTAssertEqual("John", app.textElementById(Root.orderNameText).label)
        XCTAssertEqual("Hot Coffee (Medium)", app.textElementById(Root.coffeeNameAndSizeText).label)
        XCTAssertEqual("$4.50", app.textElementById(Root.coffeePriceText).label)
        
        let collectionViewQuery = XCUIApplication().collectionViews
        
        let element = app.elementById(Root.buttonToOrderElement(0))
        element.swipeLeft()
        collectionViewQuery.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        XCTAssertEqual(0, orderList.cells.count)
    }
    
    // called after each test
    override func tearDown() {
        clearOrders()
    }
}

