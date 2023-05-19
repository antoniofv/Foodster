//
//  RecipesResource.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 19/5/23.
//

import Foundation


public final class RecipesResource: APIResource {

    init(baseUrl: String, categoryName: String) {
        super.init(
            baseUrl: baseUrl,
            path: "filter.php",
            parameters: [URLQueryItem(name: "c", value: categoryName)]
        )
    }

}
