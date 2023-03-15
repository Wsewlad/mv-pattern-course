
import Foundation

//MARK: - Screens
public enum Screens: String {
    case example
    
    case root
    case addCoffee
    case orderDetail
}

//MARK: - Example
public enum Example: AccessibilityIds {
    public var screenName: Screens { .example }
    
    // Use `<name>` + `Text` for Text elements
    case someText
    // Use `buttonTo` + `<ScreenName>` for navigation buttons
    case buttonToNavigate
    // Use `buttonFor` + `<ActionName>` for action buttons
    case buttonForSkip
    case buttonForSelectElement(index: Int)
    // Use `<name>` + `TextField` for TextFields
    case someTextField
    // Use `<name>` + `Sheet` for modals
    case shareSheet
    // Use `<name>` + `Alert` for Alerts
    case logoutAlert
    
    public var rawValue: String {
        switch self {
        case .someText: return "someText"
        case .buttonToNavigate: return "buttonToNavigate"
        case .buttonForSkip: return "buttonForSkip"
        case .someTextField: return "someTextField"
        case .shareSheet: return "shareSheet"
        case .logoutAlert: return "logoutAlert"
        case let .buttonForSelectElement(index): return "buttonForSelectElement_\(index)"
        }
    }
}
   
//MARK: - Root
public enum Root: String, AccessibilityIds {
    public var screenName: Screens { .root }
    
    case noOrdersText
    case buttonToAddNewOrder
    
    case orderNameText
    case coffeeNameAndSizeText
    case coffeePriceText
}

//MARK: - AddCoffee
public enum AddCoffee: String, AccessibilityIds {
    public var screenName: Screens { .addCoffee }
    
    case nameTextField
    case coffeeNameTextField
    case priceTextField
    case buttonForPlaceOrder
}

//MARK: - OrderDetail
public enum OrderDetail: String, AccessibilityIds {
    public var screenName: Screens { .orderDetail }
    
    case coffeeNameText
    case coffeeSizeText
    case coffeePriceText
    case buttonForDeleteOrder
    case buttonToUpdateOrder
}
