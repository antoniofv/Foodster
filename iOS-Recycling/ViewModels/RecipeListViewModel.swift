//
//  RecipeListViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation

@MainActor
final class RecipeListViewModel: ObservableObject {
    
    let api = TheMealDBAPI()
    
    @Published
    var categories: [RecipeCategory] = []
    
    func getRecipeCategories() async throws {
        self.categories = try await api.getCategories()
    }
    
    func getRecipes(forCategory category: RecipeCategory) async throws {
        if let categoryIndex = self.categories.firstIndex(where: { $0.id == category.id }) {
            self.categories[categoryIndex].recipes = try await api.getRecipes(by: category)
        }
    }
}
