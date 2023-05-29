//
//  FoodtestsApp.swift
//  Foodtests
//
//  Created by Antonio Fernandez Vega on 29/5/23.
//

import SwiftUI


@main
struct FoodtestsApp: App {

    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView(api: MockTheMealDBAPI())
                .environment(
                    \.managedObjectContext,
                     DataStoreProvider(inMemory: true).container.viewContext
                )
        }
    }

}
