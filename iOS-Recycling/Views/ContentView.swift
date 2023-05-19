//
//  ContentView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI


struct ContentView: View {

    @Environment(\.managedObjectContext) var dataContext


    var body: some View {
        TabView() {
            GroceryListView(
                viewModel: GroceryListViewModel(context: dataContext)
            )
            .tabItem {
                Label("Groceries", systemImage: "cart")
            }

            RecipeCategoryListView(
                api: TheMealDBAPI(
                    baseUrl: "https://www.themealdb.com/api/json/v1/1",
                    requestManager: RequestManager.shared
                ),
                context: dataContext
            )
            .tabItem {
                Label("Recipes", systemImage: "fork.knife")
            }
        }
    }

}


#if DEBUG

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataStoreProvider(inMemory: true).container.viewContext)
    }

}

#endif
