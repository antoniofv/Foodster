//
//  RecipeDetailResource.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 19/5/23.
//

import Foundation


public final class RecipeDetailResource: APIResource {

    init(baseUrl: String, id: String) {
        super.init(
            baseUrl: baseUrl,
            path: "lookup.php",
            parameters: [URLQueryItem(name: "i", value: id)]
        )
    }

}
