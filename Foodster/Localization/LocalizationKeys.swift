//
//  LocalizationKeys.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 21/5/23.
//

import Foundation


public enum LocalizationKeys {

    enum GroceryListView {

        enum Accessibility {
            static let addButtonHint = "groceryListView.accessibility.addButtonHint"
        }


        static let title = "groceryListView.title"
        static let emptyListMessage = "groceryListView.emptyListMessage"
    }


    enum RecipeCategoryListView {
        static let title = "recipeCategoryListView.title"
    }


    enum RecipeDetailsView {
        static let title = "recipeDetailsView.title"
        static let loadingMessage = "recipeDetailsView.loadingMessage"


        enum IngredientsSection {
            static let title = "recipeDetailsView.ingredientsSection.title"
            static let addToGroceryListButtonTitle = "recipeDetailsView.ingredientsSection.addToGroceryListButtonTitle"
        }

        enum InstructionsSection {
            static let title = "recipeDetailsView.instructionsSection.title"
            static let youtubeButtonTitle = "recipeDetailsView.instructionsSection.youtubeButtonTitle"
        }

    }

}
