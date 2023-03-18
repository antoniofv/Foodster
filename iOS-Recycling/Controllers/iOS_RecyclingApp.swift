//
//  iOS_RecyclingApp.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI

@main
struct iOS_RecyclingApp: App {

    let inMemoryDatabase = CommandLine.arguments.contains("-inMemoryDatabase")

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     DataStoreProvider(inMemory: inMemoryDatabase).container.viewContext
                )
        }
    }

}
