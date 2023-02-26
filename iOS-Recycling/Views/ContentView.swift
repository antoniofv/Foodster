//
//  ContentView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var postViewModel = PostViewModel()
    
    var body: some View {
        TabView {
            GroceryListView().tabItem {
                Label("Groceries", systemImage: "cart")
            }
            PostListView().tabItem {
                Label("Posts", systemImage: "newspaper")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
