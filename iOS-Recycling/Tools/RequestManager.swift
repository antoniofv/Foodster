//
//  RequestManager.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

class RequestManager {

    static func getRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }

}
