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

    private static let apiBaseUrlString = "https://www.themealdb.com/api/json/v1/1/"

    private static let categoriesUrl: URL! = URL(string: apiBaseUrlString + "categories.php")
    private static let recipesByCategorysUrl: URL! = URL(string: apiBaseUrlString + "filter.php")
    private static let recipeByIdUrl: URL! = URL(string: apiBaseUrlString + "lookup.php")

    typealias CategoriesDictionary = Dictionary<String, [RecipeCategory]>
    typealias RecipesDictionary = Dictionary<String, [Recipe]>

    func getCategories() async throws -> [RecipeCategory] {
        let categoriesDictionary: CategoriesDictionary = try await RequestManager.getRequest(url: TheMealDBAPI.categoriesUrl)
        return categoriesDictionary["categories"]!
    }

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe] {
        let recipesDictionary: RecipesDictionary = try await RequestManager.getRequest(
            url: TheMealDBAPI.recipesByCategorysUrl.appending(queryItems: [
                URLQueryItem(name: "c", value: category.strCategory)
            ])
        )
        
        return recipesDictionary["meals"]!
    }

    func getRecipe(id: String) async throws -> Recipe {
        let recipesDictionary: RecipesDictionary = try await RequestManager.getRequest(
            url: TheMealDBAPI.recipeByIdUrl.appending(queryItems: [
                URLQueryItem(name: "i", value: id)
            ])
        )

        return recipesDictionary["meals"]![0]
    }

}


#if DEBUG

final class MockTheMealDBAPI: TheMealDBAPIProtocol {

    func getCategories() async throws -> [RecipeCategory] {
        return [
            RecipeCategory(idCategory: "1", strCategory: "Vegan", strCategoryThumb: "", strCategoryDescription: "Vegan food!"),
            RecipeCategory(idCategory: "2", strCategory: "Beef", strCategoryThumb: "", strCategoryDescription: "Beafy beef!")
        ]
    }

    func getRecipes(by category: RecipeCategory) async throws -> [Recipe] {
        return [
            Recipe(idMeal: "1", strMeal: "Meal 1", strInstructions: "Instructions 1", ingredients: []),
            Recipe(idMeal: "2", strMeal: "Meal 2", strInstructions: "Instructions 2", ingredients: []),
        ]
    }

    func getRecipe(id: String) async throws -> Recipe {
        return Recipe(
            idMeal: "1",
            strMeal: "Bacon cheeseburger",
            strMealThumb: "https://img.freepik.com/premium-photo/craft-beef-burger-with-cheddar-bacon-pickles-purple-onion-sauce-wooden-background_74692-842.jpg",
            strInstructions: "First you make the angus meat, then you cook the bacon really crispy.\n\nPut a slice of cheddar over the bread, then the angus meat, another cheddar slice, barbecue sauce and then lots of bacon on top.\n\nAnd... that's it!",
            strYoutube: "https://www.youtube.com/watch?v=ZSrtDFR4yb8",
            ingredients: [
                RecipeIngredient(name: "Bacon", measure: "200g"),
                RecipeIngredient(name: "Cheddar cheese", measure: "100g"),
                RecipeIngredient(name: "Pickles", measure: "100g")
            ]
        )
    }

}

#endif
