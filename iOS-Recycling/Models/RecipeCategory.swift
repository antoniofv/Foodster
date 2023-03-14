//
//  RecipeCategory.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation


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
