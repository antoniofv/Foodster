//
//  RecipeListViewModel.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import CoreData
import Foundation


protocol RecipeListViewModelProtocol {

    nonisolated var categories: [RecipeCategory] { get set }

    func getRecipeCategories() async throws

    func getRecipes(forCategory category: RecipeCategory) async throws

    func getRecipe(id: String) async throws -> Recipe

}


@MainActor
final class RecipeListViewModel: RecipeListViewModelProtocol, ObservableObject {

    private let api: TheMealDBAPIProtocol
    private unowned var context: NSManagedObjectContext

    @Published
    var categories: [RecipeCategory] = []


    init(api: TheMealDBAPIProtocol, context: NSManagedObjectContext) {
        self.api = api
        self.context = context
    }

}


extension RecipeListViewModel {

    func getRecipeCategories() async throws {
        categories = try await api.getCategories()
    }

    func getRecipes(forCategory category: RecipeCategory) async throws {
        if let categoryIndex = categories.firstIndex(where: { $0.id == category.id }) {
            categories[categoryIndex].recipes = try await api.getRecipes(by: category)
        }
    }

    func getRecipe(id: String) async throws -> Recipe {
        try await api.getRecipe(id: id)
    }

    func addRecipeIngredientsToGroceryList(recipe: Recipe) {
        do {
            let request = GroceryListItem.fetchRequest()
            request.propertiesToFetch = ["name"]

            let fetchedItems = try context.fetch(request)
            let lastItemIndex = fetchedItems.last?.order ?? fetchedItems.count

            let itemSet = Set(fetchedItems.map { $0.name.lowercased() })

            try context.performAndWait {
                recipe.ingredients.enumerated().forEach { (rIndex, rIngredient) in
                    if !itemSet.contains(rIngredient.name.lowercased()) {
                        let _ = GroceryListItem(
                            context: self.context,
                            name: rIngredient.name,
                            order: lastItemIndex + rIndex
                        )
                    }
                }

                try context.save()
            }
        } catch {
            print(error)
        }
    }

}
