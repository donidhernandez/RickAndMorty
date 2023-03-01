//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import Foundation

enum NetworkError: Error {
    case invalidStatusCode
    case decodingError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .invalidStatusCode:
            return "Something went wrong"
        case .unknown:
            return "The error is unknown"
        }
    }
}
