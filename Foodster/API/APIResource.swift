//
//  APIResource.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 19/5/23.
//

import Foundation


public class APIResource {

    var baseUrl: String
    var path: String?
    var parameters: [URLQueryItem]

    var url: URL {
        var resourceUrl: URL! = URL(string: baseUrl)

        if let path {
            resourceUrl.append(component: path)
        }

        if !parameters.isEmpty {
            resourceUrl.append(queryItems: parameters)
        }

        return resourceUrl
    }


    init(baseUrl: String, path: String? = nil, parameters: [URLQueryItem] = []) {
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
    }

}
