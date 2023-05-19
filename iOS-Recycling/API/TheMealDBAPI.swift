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


#if DEBUG

final class MockTheMealDBAPI: TheMealDBAPIProtocol {

    func getCategories() async throws -> [RecipeCategory] {
        return [
            RecipeCategory(id: "1", name: "Vegan", thumbnail: "", description: "Vegan food!"),
            RecipeCategory(id: "2", name: "Beef", thumbnail: "", description: "Beafy beef!")
        ]
    }

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe] {
        return [
            Recipe(id: "1", name: "Meal 1", instructions: "Instructions 1", ingredients: []),
            Recipe(id: "2", name: "Meal 2", instructions: "Instructions 2", ingredients: []),
        ]
    }

    func getRecipe(id: String) async throws -> Recipe {
        return Recipe(
            id: "1",
            name: "Bacon cheeseburger",
            thumbnail: "https://img.freepik.com/premium-photo/craft-beef-burger-with-cheddar-bacon-pickles-purple-onion-sauce-wooden-background_74692-842.jpg",
            instructions: "First you make the angus meat, then you cook the bacon really crispy.\n\nPut a slice of cheddar over the bread, then the angus meat, another cheddar slice, barbecue sauce and then lots of bacon on top.\n\nAnd... that's it!",
            video: "https://www.youtube.com/watch?v=ZSrtDFR4yb8",
            ingredients: [
                RecipeIngredient(name: "Bacon", measure: "200g"),
                RecipeIngredient(name: "Cheddar cheese", measure: "100g"),
                RecipeIngredient(name: "Pickles", measure: "100g")
            ]
        )
    }

}

#endif
