//
//  RecipesRequest.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 30/5/23.
//

import Foundation


public final class RecipesRequest: NetworkRequest<RecipesResponse> {

    init(baseUrl: String, categoryName: String) {
        super.init(
            baseUrl: baseUrl,
            path: "/filter.php",
            parameters: [URLQueryItem(name: "c", value: categoryName)]
        )
    }

}
