//
//  HelloMVApp.swift
//  HelloMV
//
//  Created by Mohammad Azam on 8/16/22.
//

import SwiftUI

@main
struct HelloMVApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
