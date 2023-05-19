//
//  RequestManager.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation


class RequestManager {

    static let shared = RequestManager()

    let session = URLSession.shared

}


extension RequestManager {

    public func getRequest<T: Decodable>(url: URL) async throws -> T {
        async let (data, _) = try session.data(from: url)
        return try await JSONDecoder().decode(T.self, from: data)
    }

}
