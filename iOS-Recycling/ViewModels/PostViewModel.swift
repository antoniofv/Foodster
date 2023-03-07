//
//  PostViewModel.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

@MainActor
final class PostViewModel: ObservableObject {
    
    let postApi = PostAPI()
    
    @Published
    var posts: [Post] = []
    
    func getRecipeCategories() async throws {
        self.posts = try await postApi.getPosts()
    }
    
}
