//
//  RecipeCategory.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 7/3/23.
//

import Foundation


struct RecipeCategory: Decodable, Identifiable {

    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case thumbnail = "strCategoryThumb"
        case description = "strCategoryDescription"
    }


    let id: String
    let name: String
    let thumbnail: String
    let description: String

    var recipes: [Recipe] = []


    init(id: String,
         name: String,
         thumbnail: String,
         description: String,
         recipes: [Recipe] = []
    ) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.description = description
        self.recipes = recipes
    }

}
