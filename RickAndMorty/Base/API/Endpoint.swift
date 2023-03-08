//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Doni on 3/2/23.
//

import Foundation

enum Endpoint {
    case allCharacters(page: Int)
    case allEpisodes(page: Int)
    case singleCharacter(id: Int)
    case singleEpisode(id: Int)
    case allLocations(page: Int)
}

extension Endpoint {
    var host: String { "rickandmortyapi.com" }
    
    var path: String {
        switch self {
        case .allCharacters:
            return "/api/character"
        case .singleCharacter(let id):
            return "/api/character/\(id)"
        case .allEpisodes:
            return "/api/episode"
        case .singleEpisode(let id):
            return "/api/episode/\(id)"
        case .allLocations:
            return "/api/location"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .allCharacters(let page):
            return ["page": "\(page)"]
        case .allEpisodes(page: let page):
            return ["page": "\(page)"]
        case .allLocations(let page):
            return ["page": "\(page)"]
        default:
            return nil
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
