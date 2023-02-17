//
//  Post.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation

struct Post: Decodable, Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
