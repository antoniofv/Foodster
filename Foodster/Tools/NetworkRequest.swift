//
//  NetworkRequest.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 29/5/23.
//

import Foundation


public class NetworkRequest<T: Decodable>: NetworkRequestProtocol {

    typealias DataType = T

    let baseUrl: String

    let path: String?

    let parameters: [URLQueryItem]

    let httpMethod: HTTPMethod

    let headers: [String : String]

    let body: Data?

    let responseDecoder: (Data) throws -> T


    init(baseUrl: String,
         path: String? = nil,
         parameters: [URLQueryItem] = [],
         httpMethod: HTTPMethod = .get,
         headers: [String : String] = [:],
         body: Data? = nil,
         responseDecoder: ((Data) throws -> T)? = nil
    ) {
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.httpMethod = httpMethod
        self.headers = headers
        self.body = body

        if let decoder = responseDecoder {
            self.responseDecoder = decoder
        } else {
            // By default, use a JSONDecoder.
            self.responseDecoder = { data in
                try JSONDecoder().decode(T.self, from: data)
            }
        }
    }
}
