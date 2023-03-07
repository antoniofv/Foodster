//
//  PostAPI.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

class PostAPI {
    
    let apiUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getPosts() async throws -> [Post] {
        return try await RequestManager.getRequest(url: apiUrl)
    }
    
}
