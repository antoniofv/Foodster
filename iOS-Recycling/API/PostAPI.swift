//
//  PostAPI.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

class PostAPI: NSObject {
    
    let apiUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    func getPosts(completion: @escaping ([Post]) -> ()) {
        RequestManager.getRequest(url: apiUrl) { (posts) in
            completion(posts)
        }
    }
    
}
