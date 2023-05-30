//
//  RecipeDetailsRequest.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 30/5/23.
//

import Foundation


public final class RecipeDetailsRequest: NetworkRequest<RecipeDetailResponse> {

    init(baseUrl: String, id: String) {
        super.init(
            baseUrl: baseUrl,
            path: "/lookup.php",
            parameters: [URLQueryItem(name: "i", value: id)]
        )
    }

}
