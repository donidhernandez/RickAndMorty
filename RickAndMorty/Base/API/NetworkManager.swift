//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Doni on 3/2/23.
//

import Foundation

protocol NetworkManager {
    func request<T: Codable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T
}

final class NetworkManagerImpl: NetworkManager {
    
    static let shared = NetworkManagerImpl()
    
    private init() {}
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        
        guard let url = endpoint.url else {
            throw NetworkError.invalidUrl
        }
        
        let request = URLRequest(url: url)
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...300) ~= httpResponse.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkError.invalidStatusCode(statusCode: statusCode)
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .iso8601
        return try jsonDecoder.decode(T.self, from: data)        
    }
}

extension NetworkManagerImpl {
    enum NetworkError: LocalizedError {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkManagerImpl.NetworkError: Equatable {
    static func == (lhs: NetworkManagerImpl.NetworkError, rhs: NetworkManagerImpl.NetworkError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NetworkManagerImpl.NetworkError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}
