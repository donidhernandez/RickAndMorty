//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Doni on 3/2/23.
//

import Foundation

enum Endpoint {
    case allCharacters(page: Int)
   
}

extension Endpoint {
    var host: String { "rickandmortyapi.com" }
    
    var path: String {
        switch self {
        case .allCharacters:
            return "/api/character"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .allCharacters(let page):
            return ["page": "\(page)"]
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach{ item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
