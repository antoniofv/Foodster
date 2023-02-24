//
//  GroceryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import SwiftUI

struct GroceryListView: View {
    
    @StateObject private var groceryListViewModel = GroceryListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(groceryListViewModel.groceries) { grocery in
                    HStack(alignment: .center) {
                        Text(grocery.name).font(.title2).bold()
                        Spacer()
                        Text("\(grocery.quantity)")
                    }
                }.onDelete { indexSet in
                    groceryListViewModel.removeItem(atOffsets: indexSet)
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Groceries"))
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button("Add", action: addItem)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
    }
    
    private func addItem() {
        groceryListViewModel.addItem(GroceryListItem(id: "\(groceryListViewModel.groceries.count)", name: "Item \(groceryListViewModel.groceries.count)", quantity: 1))
    }
}

#if DEBUG
struct GroceryListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryListView()
    }
}
#endif
