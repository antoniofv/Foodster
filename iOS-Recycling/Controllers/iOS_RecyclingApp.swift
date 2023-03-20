//
//  iOS_RecyclingApp.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI


@main
struct iOS_RecyclingApp: App {

    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     DataStoreProvider.shared.container.viewContext
                )
        }
    }

}
