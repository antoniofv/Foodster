//
//  TheMealDBAPI.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation


protocol TheMealDBAPIProtocol {

    func getCategories() async throws -> [RecipeCategory]

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe]

    func getRecipe(id: String) async throws -> Recipe

}


final class TheMealDBAPI: TheMealDBAPIProtocol {

    private let requestManager: RequestManager

    public let baseUrl: String


    init(baseUrl: String, requestManager: RequestManager) {
        self.baseUrl = baseUrl
        self.requestManager = requestManager
    }

}


extension TheMealDBAPI {

    func getCategories() async throws -> [RecipeCategory] {
        let response: CategoriesResponse = try await requestManager.getRequest(
            url: CategoriesResource(baseUrl: baseUrl).url
        )

        return response.categories
    }

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe] {
        let response: RecipesResponse = try await requestManager.getRequest(
            url: RecipesResource(baseUrl: baseUrl, categoryName: category.name).url
        )
        
        return response.meals
    }

    func getRecipe(id: String) async throws -> Recipe {
        let response: RecipeDetailResponse = try await requestManager.getRequest(
            url: RecipeDetailResource(baseUrl: baseUrl, id: id).url
        )

        return response.recipe
    }

}
