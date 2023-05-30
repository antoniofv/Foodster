//
//  RequestManager.swift
//  Foodster
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation


class RequestManager {

    static let shared = RequestManager()

    let session = URLSession.shared

}


extension RequestManager {

    public func request<T: Decodable>(_ request: any NetworkRequestProtocol) async throws -> T {
        let urlRequest = buildURLRequest(from: request)
        async let (data, _) = try session.data(for: urlRequest)
        return try await request.responseDecoder(data) as! T
    }

}


extension RequestManager {

    private func buildURLRequest(from request: any NetworkRequestProtocol) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body
        urlRequest.allHTTPHeaderFields = request.headers
        return urlRequest
    }

}
