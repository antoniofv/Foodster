//
//  GroceryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import SwiftUI


struct GroceryListView: View {

    @Environment(\.managedObjectContext) var dataContext

    @FetchRequest(
        fetchRequest: GroceryListItem.fetchRequest(),
        animation: .default
    )
    var items: FetchedResults<GroceryListItem>

//    @StateObject private var groceryListViewModel = GroceryListViewModel()
    @FocusState private var focusedItem: UUID?
    
    var body: some View {
        NavigationStack {
            List() {
                Section {
                    ForEach(items, id: \.id) {
                        GroceryListCell(
                            groceryListItem:
                                $0,
                            focusState: $focusedItem,
                            isEditing: focusedItem == $0.id
                        )
                        .onSubmit {
                            focusedItem = nil
                            saveContext()
                        }
                        .onChange(of: $0) { newValue in
                            print(newValue)
                        }
                    }
                    .onDelete { indexSet in
//                        groceryListViewModel.removeItem(atOffsets: indexSet)
                        let item = self.items[indexSet.first!]
                            self.dataContext.delete(item)
                            saveContext()
                    }
                    .onMove { from, to in
//                        groceryListViewModel.moveItem(fromOffsets: from, toOffset: to)

                        // FIXME: This is the most inefficient way to reorder.
                        var newArray = Array(items)
                        newArray.move(fromOffsets: from, toOffset: to)

                        newArray.enumerated().forEach { (index, element) in
                            element.order = index
                        }

                        saveContext()
                    }
                    .listRowInsets(EdgeInsets())
                    .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.visible)
            .navigationBarTitle(Text("Groceries"))
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .background(.gray.opacity(0.15))
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        withAnimation {
                            addItem()
                        }
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                    .accessibilityIdentifier("addButton")
                    .accessibilityHint(Text("Add a grocery item to the list"))
                }
            }
            .overlay(Group {
                // Empty list view
//                if groceryListViewModel.groceries.isEmpty {
                if self.items.isEmpty {
                    Text("Add some items to the list!")
                        .accessibilityIdentifier("emptyListText")
                        .font(.title2)
                        .foregroundColor(Color(white: 0.4))
                }
            })
        }
    }
    
    private func addItem() {
        let newItem = GroceryListItem(
            context: self.dataContext,
            name: "",
            order: self.items.count
        )

        print(newItem)

//        self.groceryListViewModel.addItem(newItem)
        self.focusedItem = newItem.id

        saveContext()
    }

    private func saveContext() {
        Task {
            await self.dataContext.perform {
                do {
                    try self.dataContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }

}


#if DEBUG

struct GroceryListView_Previews: PreviewProvider {

    static var previews: some View {
        GroceryListView()
            .environment(
                \.managedObjectContext,
                 DataStoreProvider(inMemory: true).container.viewContext
            )
    }

}

#endif
