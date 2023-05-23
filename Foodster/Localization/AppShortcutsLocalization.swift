//
//  AppShortcutsLocalization.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 22/5/23.
//

import AppIntents
import SwiftUI


public struct AppShortcutsLocalization {

}


extension AppShortcutsLocalization {

    public static func getStringResource(_ key: String) -> LocalizedStringResource {
        LocalizedStringResource(String.LocalizationValue(key))
    }

    public static func getString(_ key: String) -> String {
        String(localized: String.LocalizationValue(key))
    }

}


extension AppShortcutsLocalization {

    public enum Keys {

        enum AddItemToGroceryList {

            enum Parameter {

                enum Item {

                    enum Dialog {
                        static let prompt = "AddItemToGroceryList.parameter.item.dialog.prompt"
                        static let confirmation = "AddItemToGroceryList.parameter.item.dialog.confirmation"
                        static let responseSuccess = "AddItemToGroceryList.parameter.item.dialog.responseSuccess"
                    }

                    static let title = "AddItemToGroceryList.parameter.item.title"
                    static let requestValueDialog = "AddItemToGroceryList.parameter.item.requestValueDialog"
                    static let summary = "AddItemToGroceryList.parameter.item.summary"
                }

            }

            static let title = "AddItemToGroceryList.title"
            static let description = "AddItemToGroceryList.description"

        }

    }

}
