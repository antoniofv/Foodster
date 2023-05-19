//
//  CategoriesResource.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 19/5/23.
//

import Foundation


public final class CategoriesResource: APIResource {

    init(baseUrl: String) {
        super.init(baseUrl: baseUrl, path: "categories.php")
    }

}
