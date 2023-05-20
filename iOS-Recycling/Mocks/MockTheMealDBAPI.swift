//
//  MockTheMealDBAPI.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 20/5/23.
//

import Foundation


#if DEBUG

final class MockTheMealDBAPI: TheMealDBAPIProtocol {

    let categories = [MockRecipeCategory.category1, MockRecipeCategory.category2]

    func getCategories() async throws -> [RecipeCategory] {
        return categories
    }

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe] {
        let category = categories.first { $0.id == category.id }
        return category?.recipes ?? []
    }

    func getRecipe(id: String) async throws -> Recipe {
        let recipes = categories.flatMap { $0.recipes }
        return recipes.first { $0.id == id }!
    }

}

#endif
