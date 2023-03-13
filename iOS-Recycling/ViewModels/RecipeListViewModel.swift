//
//  RecipeListViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation


protocol RecipeListViewModelProtocol {

    nonisolated var categories: [RecipeCategory] { get set }

    func getRecipeCategories() async throws

    func getRecipes(forCategory category: RecipeCategory) async throws

    func getRecipe(id: String) async throws -> Recipe

}

@MainActor
class RecipeListViewModel: RecipeListViewModelProtocol, ObservableObject {

    private let api: TheMealDBAPIProtocol

    @Published
    var categories: [RecipeCategory] = []

    init(api: TheMealDBAPIProtocol) {
        self.api = api
    }

    func getRecipeCategories() async throws {
        self.categories = try await api.getCategories()
    }

    func getRecipes(forCategory category: RecipeCategory) async throws {
        if let categoryIndex = self.categories.firstIndex(where: { $0.id == category.id }) {
            self.categories[categoryIndex].recipes = try await api.getRecipes(by: category)
        }
    }

    func getRecipe(id: String) async throws -> Recipe {
        try await api.getRecipe(id: id)
    }

}
