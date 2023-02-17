//
//  RequestManager.swift
//  iOS-Recycling
//
//  Created by Antonio Fernandez Vega on 17/2/23.
//

import Foundation


class RequestManager: NSObject {
    
    static func getRequest<T: Decodable>(url: URL, completion: @escaping ([T]) -> ()) {
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                
                let outputData = try! jsonDecoder.decode([T].self, from: data)
                completion(outputData)
            }
        }.resume()
        
    }
    
}
