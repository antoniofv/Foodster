//
//  TheMealDBAPI.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation



class TheMealDBAPI {
    
    private static let apiBaseUrlString = "https://www.themealdb.com/api/json/v1/1/"
    
    private static let categoriesUrl = URL(string: apiBaseUrlString + "categories.php")!
    private static let recipesByCategorysUrl = URL(string: apiBaseUrlString + "filter.php")!
    
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
}
