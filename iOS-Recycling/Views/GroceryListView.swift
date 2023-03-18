//
//  GroceryListView.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import Combine
import SwiftUI


struct GroceryListView: View {

    @StateObject private var groceryListViewModel: GroceryListViewModel
    @FocusState private var focusedItem: UUID?

    @State var timer: Timer?


    init(viewModel: GroceryListViewModel) {
        _groceryListViewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        NavigationStack {
            List() {
                Section {
                    ForEach(groceryListViewModel.groceries, id: \.id) {
                        GroceryListCell(
                            groceryListItem:
                                $0,
                            focusState: $focusedItem,
                            isEditing: focusedItem == $0.id
                        )
                        .onSubmit {
                            self.focusedItem = nil
                            self.timer?.invalidate()
                            self.groceryListViewModel.save()
                        }
                        .onChange(of: $0.isChecked) { _ in
                            // Remove focus from selected element if a checkbox is tapped.
                            self.focusedItem = nil
                        }
                        .onReceive($0.objectWillChange) {
                            // Wait before committing changes, to prevent unnecessary
                            // writes to the database if more changes happen in a short time.
                            self.timer?.invalidate()

                            self.timer = Timer.scheduledTimer(
                                withTimeInterval: 1,
                                repeats: false,
                                block: { timer in
                                    self.groceryListViewModel.save()
                                    self.timer = nil
                                }
                            )
                        }

                    }
                    .onDelete { indexSet in
                        self.focusedItem = nil
                        self.groceryListViewModel.removeItem(atOffsets: indexSet)
                    }
                    .onMove { from, to in
                        self.focusedItem = nil
                        self.groceryListViewModel.moveItem(
                            fromOffsets: from,
                            toOffset: to
                        )
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
                if self.groceryListViewModel.groceries.isEmpty {
                    Text("Add some items to the list!")
                        .accessibilityIdentifier("emptyListText")
                        .font(.title2)
                        .foregroundColor(Color(white: 0.4))
                }
            })
        }
    }

    private func addItem() {
        let newItem = self.groceryListViewModel.createItem()
        self.focusedItem = newItem.id
    }

}


#if DEBUG

struct GroceryListView_Previews: PreviewProvider {

    static var previews: some View {
        let dataStoreProvider = DataStoreProvider(inMemory: true)
        let viewModel = GroceryListViewModel(
            context: dataStoreProvider.container.viewContext
        )

        GroceryListView(viewModel: viewModel)
            .environment(
                \.managedObjectContext,
                 dataStoreProvider.container.viewContext
            )
    }

}

#endif
