//
//  NetworkRequestProtocol.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 29/5/23.
//

import Foundation


public enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case update = "UPDATE"

}


protocol NetworkRequestProtocol {

    associatedtype DataType: Decodable

    var baseUrl: String { get }
    var path: String? { get }
    var parameters: [URLQueryItem] { get }

    var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: Data? { get }

    var url: URL { get }
    var responseDecoder: (Data) throws -> DataType { get }

}


extension NetworkRequestProtocol {

    var url: URL {
        var components = URLComponents(string: baseUrl)!
        components.path += path ?? ""

        if !parameters.isEmpty {
            components.queryItems = parameters
        }

        return components.url!
    }

}
