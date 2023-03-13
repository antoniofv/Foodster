//
//  RecipeCategory.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation

struct RecipeIngredient: Identifiable {

    let id: UUID = UUID()
    let name: String
    let measure: String

    var description: String {
        "\(measure) \(name)"
    }

}


struct Recipe: Decodable, Identifiable {

    enum CodingKeys: CodingKey {
        case idMeal
        case strMeal
        case strMealThumb
        case strInstructions
        case strYoutube

        // Ingredient keys
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20

        // Ingredient measure keys
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }

    // API uses individual keys for ingredients, so this keyset contains them all.
    private static let ingredientKeyset: [(CodingKeys, CodingKeys)] = [
        (.strIngredient1, .strMeasure1),
        (.strIngredient2, .strMeasure2),
        (.strIngredient3, .strMeasure3),
        (.strIngredient4, .strMeasure4),
        (.strIngredient5, .strMeasure5),
        (.strIngredient6, .strMeasure6),
        (.strIngredient7, .strMeasure7),
        (.strIngredient8, .strMeasure8),
        (.strIngredient9, .strMeasure9),
        (.strIngredient10, .strMeasure10),
        (.strIngredient11, .strMeasure11),
        (.strIngredient12, .strMeasure12),
        (.strIngredient13, .strMeasure13),
        (.strIngredient14, .strMeasure14),
        (.strIngredient15, .strMeasure15),
        (.strIngredient16, .strMeasure16),
        (.strIngredient17, .strMeasure17),
        (.strIngredient18, .strMeasure18),
        (.strIngredient19, .strMeasure19),
        (.strIngredient20, .strMeasure20),
    ]

    private let idMeal: String
    let strMeal: String
    let strMealThumb: String
    var strInstructions: String?
    var strYoutube: String?
    var ingredients: [RecipeIngredient] = []

    // Needed by the 'Identifiable' protocol.
    var id: String {
        idMeal
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Self.CodingKeys)

        self.idMeal = try container.decode(String.self, forKey: .idMeal)
        self.strMeal = try container.decode(String.self, forKey: .strMeal)
        self.strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        self.strInstructions = try container.decodeIfPresent(String.self, forKey: .strInstructions)
        self.strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        self.ingredients = []

        for (ingredientKey, measureKey) in Recipe.ingredientKeyset {
            do {
                let ingredientName = try container.decode(String.self, forKey: ingredientKey)
                let ingredientMeasure = try container.decode(String.self, forKey: measureKey)

                if (!ingredientName.isEmpty) {
                    self.ingredients.append(
                        RecipeIngredient(name: ingredientName, measure: ingredientMeasure)
                    )
                }
            } catch {
                break
            }
        }
    }

    init(
        idMeal: String,
        strMeal: String,
        strMealThumb: String = "",
        strInstructions: String,
        strYoutube: String = "",
        ingredients: [RecipeIngredient]
    ) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.strInstructions = strInstructions
        self.strYoutube = strYoutube
        self.ingredients = ingredients
    }

}

struct RecipeCategory: Decodable, Identifiable {

    enum CodingKeys: CodingKey {
        case idCategory
        case strCategory
        case strCategoryThumb
        case strCategoryDescription
    }

    private let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String

    // Needed by the 'Identifiable' protocol.
    var id: String {
        idCategory
    }

    var recipes: [Recipe] = []

    init(idCategory: String,
         strCategory: String,
         strCategoryThumb: String,
         strCategoryDescription: String,
         recipes: [Recipe] = []
    ) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
        self.recipes = recipes
    }
}
