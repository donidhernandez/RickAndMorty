//
//  LocationsViewModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import Foundation

final class LocationsViewModel: ObservableObject {
    @Published private(set) var locations: [Location] = []
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    @Published var hasError = false
    
    private(set) var page = 1
    private(set) var totalPages: Int?
    
    private let networkManager: NetworkManager!
    
    init(networkManager: NetworkManager = NetworkManagerImpl.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getAllLocations() async {
        do {
            let response = try await networkManager.request(session: .shared, .allLocations(page: page), type: LocationsResponse.self)
            self.locations = response.results
            self.totalPages = response.info.pages
        } catch {
            self.hasError = true
            if let networkError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func getNextSetOfLocations() async {
        guard page != totalPages else { return }
        
        page += 1
        
        do {
            let response = try await networkManager.request(session: .shared, .allLocations(page: page), type: LocationsResponse.self)
            self.totalPages = response.info.pages
            self.locations += response.results
            
        } catch {
            self.hasError = true
            if let networkError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func getLocationCharacters(location: Location) async -> [Character] {
        var characters: [Character] = []
        try? await location.residents.asyncForEach { characterURL in
            let splittedURL = characterURL.split(separator: "/")
            let id = Int(splittedURL.last ?? "1")!
            let response = try await networkManager.request(session: .shared, .singleCharacter(id: id), type: Character.self)
            characters.append(response)
        }
        
        return characters
    }
    
    func hasReachedEnd(of location: Location) -> Bool {
        locations.last?.id == location.id
    }
}
