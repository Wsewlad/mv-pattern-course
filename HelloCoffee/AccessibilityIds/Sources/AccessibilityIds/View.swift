import SwiftUI

public extension View {
    func setAccessiblityScreen(_ id: Screens) -> some View {
        self
            .accessibilityIdentifier(id.rawValue)
    }
    
    func setAccessiblityId<T: AccessibilityIds>(screen: T.Type, _ id: T) -> some View {
        self
            .accessibilityIdentifier(id.elementValue)
    }
}

private struct Test: View {
    var body: some View {
        VStack {
            Text("")
                .setAccessiblityScreen(.example)
            Text("")
                .setAccessiblityId(screen: Example.self, .buttonToNavigate)
        }
    }
}
