//
//  RequestManager.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

class RequestManager: NSObject {
    
    static func getRequest<T: Decodable>(url: URL) async throws -> [T] {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let jsonDecoder = JSONDecoder()
        let outputData = try jsonDecoder.decode([T].self, from: data)

        return outputData
    }

}
