import Foundation

public protocol AccessibilityIds {
    var rawValue: String { get }
    var elementValue: String { get }
    var screenName: Screens { get }
}

public extension AccessibilityIds {
    var elementValue: String {
        screenName.rawValue + "_" + rawValue
    }
}
