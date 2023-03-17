//
//  BudgetsAppApp.swift
//  BudgetsApp
//
//  Created by  Vladyslav Fil on 17.03.2023.
//

import SwiftUI

@main
struct BudgetsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, CoreDataManager.shared.viewContext)
        }
    }
}
