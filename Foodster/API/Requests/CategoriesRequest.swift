//
//  CategoriesRequest.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 30/5/23.
//

import Foundation


public final class CategoriesRequest: NetworkRequest<CategoriesResponse> {

    init(baseUrl: String) {
        super.init(baseUrl: baseUrl, path: "/categories.php")
    }

}
