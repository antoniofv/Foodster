//
//  GroceryListView.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 24/2/23.
//

import Combine
import SwiftUI


struct BoundsPreferenceKey: PreferenceKey {
    typealias Value = [Anchor<CGRect>]

    static var defaultValue: Value = []

    static func reduce(
        value: inout Value,
        nextValue: () -> Value
    ) {
        value.append(contentsOf: nextValue())
    }
}

struct GroceryListView: View {

    @StateObject private var groceryListViewModel: GroceryListViewModel
    @FocusState private var focusedItem: UUID?

    @State var timer: Timer?

    @Environment(\.defaultMinListRowHeight) var minRowHeight
    @State private var listHeight = CGFloat.infinity


    init(viewModel: GroceryListViewModel) {
        _groceryListViewModel = StateObject(wrappedValue: viewModel)
    }


    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                List() {
                    Section {
                        ForEach(groceryListViewModel.groceries, id: \.id) { item in
                            GroceryListCell(
                                groceryListItem:
                                    item,
                                focusState: $focusedItem,
                                isEditing: focusedItem == item.id
                            )
                            .onSubmit {
//                                focusedItem = nil
                                timer?.invalidate()
                                groceryListViewModel.save()
                                addItem()
                            }
                            .onChange(of: item.isChecked) { _ in
                                // Remove focus from selected element if a checkbox is tapped.
                                focusedItem = nil
                            }
                            .onReceive(item.objectWillChange) {
                                // Wait before committing changes, to prevent unnecessary
                                // writes to the database if more changes happen in a short time.
                                timer?.invalidate()

                                timer = Timer.scheduledTimer(
                                    withTimeInterval: 1,
                                    repeats: false
                                ) { _ in
                                    groceryListViewModel.save()
                                    timer = nil
                                }
                            }
                        }
                        .onDelete { indexSet in
                            focusedItem = nil
                            groceryListViewModel.removeItem(atOffsets: indexSet)
                        }
                        .onMove { from, to in
                            focusedItem = nil
                            groceryListViewModel.moveItem(
                                fromOffsets: from,
                                toOffset: to
                            )
                        }
                        .listRowInsets(EdgeInsets())
                        .alignmentGuide(.listRowSeparatorLeading) { $0[.leading] }
                        .anchorPreference(key: BoundsPreferenceKey.self, value: .bounds) { [$0] }
                        .listRowSeparator(.visible)

                        // FIXME: Adds a view to dismiss the keyboard by tapping on the empty space on the list.
                        if focusedItem != nil
                            && !groceryListViewModel.groceries.isEmpty
                        {
                            dismissalArea(proxy: proxy)
                        }
                    }

                }
                .listStyle(.grouped)
                .navigationBarTitle(
                    Text(LocalizedStringKey(LocalizationKeys.GroceryListView.title))
                )
                .toolbarBackground(Color.green, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .background(Assets.Colors.groceryListBackground)
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
                        .accessibilityIdentifier(AccessibilityIdentifiers.GroceryListView.addButton)
                        .accessibilityHint(
                            Text(LocalizedStringKey(LocalizationKeys.GroceryListView.Accessibility.addButtonHint))
                        )
                    }
                }
                .overlay(Group {
                    // Empty list view
                    if groceryListViewModel.groceries.isEmpty {
                        VStack {
                            Text(LocalizedStringKey(LocalizationKeys.GroceryListView.emptyListMessage))
                                .accessibilityIdentifier(AccessibilityIdentifiers.GroceryListView.emptyListMessage)
                                .font(.title2)
                                .foregroundColor(Color(white: 0.4))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Assets.Colors.groceryListBackground)
                    }
                })
                .backgroundPreferenceValue(BoundsPreferenceKey.self) { rects in
                    GeometryReader { gr in
                        self.updateListFrame(gp: gr, anchors: rects)
                    }
                }
//                .gesture(
//                    SpatialTapGesture(coordinateSpace: .local).onEnded { event in
//                        // Remove focus only when the tap location is beyond the list content.
//                        if (focusedItem != nil && event.location.y > listHeight) {
//                            focusedItem = nil
//                        }
//                    },
//                    including: .subviews
//                )
            }
        }
    }

    private func dismissalArea(proxy: GeometryProxy) -> some View {
        ZStack {
            Color.clear
        }
        .id("dismissal-area")
        .accessibilityIdentifier(AccessibilityIdentifiers.GroceryListView.dismissalArea)
        .frame(height: max(0, proxy.size.height - listHeight - 30))
        .listRowInsets(.zero)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .allowsHitTesting(true)
        .contentShape(Rectangle())
        .onTapGesture {
            focusedItem = nil
        }
    }

}


extension GroceryListView {

    private func addItem() {
        let newItem = groceryListViewModel.createItem()
        focusedItem = newItem.id
    }

    private func updateListFrame(gp: GeometryProxy, anchors: [Anchor<CGRect>]) -> some View {
        let contentHeight = anchors.reduce(CGFloat.zero) { $0 + gp[$1].size.height }
        DispatchQueue.main.async {
            self.listHeight = contentHeight
        }
        return Color.clear
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
