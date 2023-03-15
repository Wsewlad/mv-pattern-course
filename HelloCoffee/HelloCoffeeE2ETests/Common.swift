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
    func buttonElementById(_ id: AccessibilityIds) -> XCUIElement {
        self.buttons[id.elementValue]
    }
    
    func tryTapButton(_ id: AccessibilityIds) {
        let button = buttonElementById(id)
        XCTAssertTrue(button.exists)
        button.tap()
    }
    
    func tryTapButtonWithTimeout(_ id: AccessibilityIds, timeout: TimeInterval = 1.5) {
        let button = buttonElementById(id)
        XCTAssertTrue(button.waitForExistence(timeout: timeout))
        button.tap()
    }
}

//MARK: - Screens + staticTexts
extension XCUIApplication {
    func textElementByScreen(_ screen: Screens) -> XCUIElement {
        self.staticTexts[screen.rawValue]
    }
    
    func waitForTextElementExistence(screen: Screens, timeout: TimeInterval = 0.1) -> Bool {
        textElementByScreen(screen).waitForExistence(timeout: timeout)
    }
}

//MARK: - AccessibilityIds



//MARK: - textFields
extension XCUIApplication {
    func textFieldElementById(_ id: AccessibilityIds) -> XCUIElement {
        self.textFields[id.elementValue]
    }
    
    func tryEnterTextIntoTextField(_ id: AccessibilityIds, text: String, timeout: TimeInterval = 1.5) {
        let textField = textFieldElementById(id)
        XCTAssertTrue(textField.waitForExistence(timeout: timeout))
        textField.clearAndEnterText(text: text)
    }
}

//MARK: - secureTextFields
extension XCUIApplication {
    func secureTextFieldElementById(_ id: AccessibilityIds) -> XCUIElement {
        self.textFields[id.elementValue]
    }
    
    func tryEnterTextIntoSecureTextField(_ id: AccessibilityIds, text: String) {
        let secureTextField = secureTextFieldElementById(id)
        XCTAssertTrue(secureTextField.exists)
        secureTextField.clearAndEnterText(text: text)
    }
}

//MARK: - descendants
extension XCUIApplication {
    func elementById(_ id: AccessibilityIds) -> XCUIElement {
        self.descendants(matching: .any)
            .matching(
                identifier: id.elementValue
            ).element
    }
    
    func tryTapElementWithTimeout(_ id: AccessibilityIds, timeout: TimeInterval = 1.5) {
        let element = elementById(id)
        XCTAssertTrue(element.waitForExistence(timeout: timeout))
        element.tap()
    }
}
    
//MARK: - staticTexts
extension XCUIApplication {
    func textElementById(_ id: AccessibilityIds) -> XCUIElement {
        self.staticTexts[id.elementValue]
    }
    
    func isWithTimeoutHittable(_ element: AccessibilityIds, timeout: TimeInterval = 0.1) -> Bool {
        let screenTitle = self.staticTexts[element.elementValue]
        return screenTitle.waitForExistence(timeout: timeout) && screenTitle.isHittable
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

//MARK: - clearAndEnterText
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
