//
//  PostViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

class PostViewModel {
    
    let postApi = PostAPI()
    
    func getPosts(completion: @escaping ([Post]) -> ()) {
        postApi.getPosts(completion: completion)
    }
    
}
