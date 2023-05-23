//
//  AddItemToGroceryList.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 19/3/23.
//

import AppIntents
import Foundation


@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct AddItemToGroceryList: AppIntent {

    static let intentClassName = "AddItemToGroceryListIntent"


    static var title = AppShortcutsLocalization.getStringResource(
        AppShortcutsLocalization.Keys.AddItemToGroceryList.title
    )

    static var description = IntentDescription(
        AppShortcutsLocalization.getStringResource(
            AppShortcutsLocalization.Keys.AddItemToGroceryList.description
        )
    )


    @Parameter(
        title: "item",
        requestValueDialog: IntentDialog(
            AppShortcutsLocalization.getStringResource(
                AppShortcutsLocalization.Keys.AddItemToGroceryList.Parameter.Item.requestValueDialog
            )
        )
    )
    var item: String

    static var parameterSummary: some ParameterSummary {
        /*
         * For some reason, using a `ParameterSummaryString` with the constant value
         * from `AppShortcutsLocalization` does not work as expected. The key is hardcoded
         * here and the translation is contained in the `Localizable.strings` file.
         */
        Summary("AddItemToGroceryList.parameter.item.summary")
    }


    @MainActor
    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        let dataStoreProvider = DataStoreProvider.shared
        let context = dataStoreProvider.container.viewContext

        let result = try context.count(for: GroceryListItem.fetchRequest())

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
        IntentDialog(
            AppShortcutsLocalization.getStringResource(
                AppShortcutsLocalization.Keys.AddItemToGroceryList.Parameter.Item.Dialog.prompt
            )
        )
    }

    static func itemParameterConfirmation(item: String) -> Self {
        let formatString = AppShortcutsLocalization.getString(
            AppShortcutsLocalization.Keys.AddItemToGroceryList.Parameter.Item.Dialog.confirmation
        )
        return IntentDialog(stringLiteral: String(format: formatString, item))
    }

    static func responseSuccess(item: String) -> Self {
        let formatString = AppShortcutsLocalization.getString(
            AppShortcutsLocalization.Keys.AddItemToGroceryList.Parameter.Item.Dialog.responseSuccess
        )
        return IntentDialog(stringLiteral: String(format: formatString, item))
    }

}


@available(iOS 16.0, *)
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
