//
//  ContentView.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI


struct ContentView: View {

    private enum TabIdentifier {
        case groceries
        case recipes
    }


    @Environment(\.managedObjectContext) var dataContext

    @State private var selectedTab = TabIdentifier.groceries

    let api: TheMealDBAPIProtocol!


    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                GroceryListView(
                    viewModel: GroceryListViewModel(context: dataContext)
                )
                .tabItem {
                    Label(
                        LocalizedStringKey(LocalizationKeys.GroceryListView.title),
                        systemImage: "cart"
                    )
                }
                .tag(TabIdentifier.groceries)

                RecipeCategoryListView(api: api, context: dataContext)
                    .tabItem {
                        Label(
                            LocalizedStringKey(LocalizationKeys.RecipeCategoryListView.title),
                            systemImage: "fork.knife"
                        )
                    }
                    .tag(TabIdentifier.recipes)
            }
            .toolbarBackground(Color.primary.opacity(0.01), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(tabBarTintColor(forTab: selectedTab))

    }

}


extension ContentView {

    private func tabBarTintColor(forTab tab: TabIdentifier) -> Color {
        switch tab {
        case .groceries: return .green
        case .recipes: return .orange
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
