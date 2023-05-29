//
//  iOS_RecyclingApp.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI


@main
struct FoodsterApp: App {

    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        let api = TheMealDBAPI(
            baseUrl: "https://www.themealdb.com/api/json/v1/1",
            requestManager: RequestManager.shared
        )

        WindowGroup {
            ContentView(api: api)
                .environment(
                    \.managedObjectContext,
                     DataStoreProvider.shared.container.viewContext
                )
        }
    }

}
