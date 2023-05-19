//
//  RecipeDetailResponse.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 19/5/23.
//

import Foundation


struct RecipeDetailResponse: Decodable {

    enum ResponseError: Error {
        case noRecipes
    }

    enum CodingKeys: String, CodingKey {
        case meals
    }


    let recipe: Recipe


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys)

        let meals = try container.decode(Array<Recipe>.self, forKey: .meals)

        guard let recipe = meals.first else {
            throw ResponseError.noRecipes
        }

        self.recipe = recipe
    }

}
