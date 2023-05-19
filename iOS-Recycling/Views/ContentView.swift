//
//  ContentView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI


struct ContentView: View {

    @Environment(\.managedObjectContext) var dataContext

    let api: TheMealDBAPIProtocol!


    var body: some View {
        TabView() {
            GroceryListView(
                viewModel: GroceryListViewModel(context: dataContext)
            )
            .tabItem {
                Label("Groceries", systemImage: "cart")
            }

            RecipeCategoryListView(api: api, context: dataContext)
            .tabItem {
                Label("Recipes", systemImage: "fork.knife")
            }
        }
    }

}


#if DEBUG

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(api: MockTheMealDBAPI())
            .environment(\.managedObjectContext, DataStoreProvider(inMemory: true).container.viewContext)
    }

}

#endif
