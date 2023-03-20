//
//  AddItemToGroceryList.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 19/3/23.
//

import AppIntents
import Foundation


@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct AddItemToGroceryList: AppIntent {

    static let intentClassName = "AddItemToGroceryListIntent"

    static var title: LocalizedStringResource = "Add to grocery list"
    static var description = IntentDescription("Add an item to the grocery list")

    @Parameter(title: "item you want to add")
    var item: String

    static var parameterSummary: some ParameterSummary {
        Summary("Adds \(\.$item) to the grocery list")
    }


    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let dataStoreProvider = DataStoreProvider.shared
        let context = dataStoreProvider.container.viewContext

        let request = GroceryListItem.fetchRequest()
        let result = try context.fetch(request).count

        let _ = GroceryListItem(context: context, name: item, order: result)
        try context.save()

        return .result(
            value: item,
            dialog: IntentDialog.responseSuccess(item: item)
        )
    }

}


fileprivate extension IntentDialog {

    static var itemParameterPrompt: Self {
        "What do you want to add?"
    }

    static func itemParameterConfirmation(item: String) -> Self {
        "Just to confirm, you wanted ‘\(item)’?"
    }

    static func responseSuccess(item: String) -> Self {
        "Added \"\(item)\" to your grocery list."
    }

}


@available(iOS 16.0, *)
/// The `AppShortcutsProvider`.
struct GlobalShortcutsProvider: AppShortcutsProvider {

    static var shortcutTileColor: ShortcutTileColor = .navy

    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: AddItemToGroceryList(),
            phrases: [
                "Add an item to \(.applicationName)",
                "Add item to \(.applicationName)",
                "Add to \(.applicationName)",
                "Add a product to \(.applicationName)",
                "Add product to \(.applicationName)",
                "Add something to \(.applicationName)"
            ],
            systemImageName: "cart"
        )
    }

}
