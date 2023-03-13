//
//  Common.swift
//  HelloCoffeeE2ETests
//
//  Created by  Vladyslav Fil on 12.03.2023.
//

import XCTest
import AccessibilityIds

extension XCTestCase {
    static let env = "ENV"
    
    enum EnvValue: String {
        case test = "TEST"
    }
}

//MARK: - Launch Argument
extension XCTestCase {
    enum LaunchArgument {
        case env
        
        var launchEnvironment: [String : String] {
            var result: [String : String] = [:]
            switch self {
            case .env:
                result[XCTestCase.env] = EnvValue.test.rawValue
            }
            return result
        }
    }
}

//MARK: - Buttons
extension XCUIApplication {
    
    func tryTapButton(_ element: AccessibilityIds) {
        let button = self.buttons[element.elementValue]
        XCTAssertTrue(button.exists)
        button.tap()
    }
    
    func tryTapButtonWithTimeout(_ element: AccessibilityIds, timeout: TimeInterval = 1.5) {
        let button = self.buttons[element.elementValue]
        XCTAssertTrue(button.waitForExistence(timeout: timeout))
        button.tap()
    }
    
    func tryTapElementWithTimeout(_ element: AccessibilityIds, timeout: TimeInterval = 1.5) {
        let button = self.otherElements[element.elementValue]
        XCTAssertTrue(button.waitForExistence(timeout: timeout))
        button.tap()
    }
    
    func tryEnterTextIntoTextField(_ element: AccessibilityIds, text: String, timeout: TimeInterval = 1.5) {
        let textField = self.textFields[element.elementValue]
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        textField.clearAndEnterText(text: text)
    }
    
    func tryEnterTextIntoSecureTextField(_ element: AccessibilityIds, text: String) {
        let secureTextField = self.secureTextFields[element.elementValue]
        XCTAssertTrue(secureTextField.exists)
        secureTextField.clearAndEnterText(text: text)
    }
}

//MARK: - Screens
extension XCUIApplication {
    func isWithTimeoutPresented(screen: Screens, timeout: TimeInterval = 0.1) -> Bool {
        let screenTitle = self.staticTexts[screen.rawValue]
        return screenTitle.waitForExistence(timeout: timeout)
    }
    
    func isPresented(screen: Screens) -> Bool {
        let screenTitle = self.staticTexts[screen.rawValue]
        return screenTitle.exists
    }
    
    func isPresented(_ element: AccessibilityIds) -> Bool {
        let screenTitle = self.staticTexts[element.elementValue]
        return screenTitle.exists
    }
    
    func isHittable(_ element: AccessibilityIds) -> Bool {
        let screenTitle = self.staticTexts[element.elementValue]
        return screenTitle.isHittable
    }
    
    func isWithTimeoutHittable(_ element: AccessibilityIds, timeout: TimeInterval = 0.1) -> Bool {
        let screenTitle = self.staticTexts[element.elementValue]
        return screenTitle.waitForExistence(timeout: timeout) && screenTitle.isHittable
    }
    
    func label(of element: AccessibilityIds) -> String {
       return self.staticTexts[element.elementValue].label
    }
}

//MARK: - Set Launch Arguments
extension XCUIApplication {
    /**
    Merge Launch Environment arguments
     - Parameter arguments: `LaunchArguments` to merge with the `launchEnvironment`, default: `[.env]`
    */
    func setLaunchArguments(_ arguments: [XCTestCase.LaunchArgument] = [.env]) {
        for argument in arguments {
            launchEnvironment.merge(argument.launchEnvironment) { (_, new) in new }
        }
        launch()
        terminate()
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }

        self.doubleTap()

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)

        self.typeText(deleteString)
        
        text.forEach { character in
            self.typeText("\(character)")
        }
    }
}
