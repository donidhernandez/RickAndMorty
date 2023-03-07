//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    @Published private(set) var characters: [Character] = []
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    @Published private(set) var characterDetail: Character!
    @Published var hasError = false
    
    private(set) var page = 1
    private(set) var totalPages: Int?
    
    private let networkManager: NetworkManager!
    
    
    init(networkManager: NetworkManager = NetworkManagerImpl.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getAllCharacters() async {
        do {
            let response = try await networkManager.request(session: .shared, .allCharacters(page: page), type: CharactersResponse.self)
            self.totalPages = response.info.pages
            self.characters = response.results
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
    func getSingleCharacter(id: Int) async {
        do {
            let response = try await networkManager.request(session: .shared, .singleEpisode(id: id), type: Character.self)
            self.characterDetail = response
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
    func getNextSetOfCharacters() async {
        guard page != totalPages else { return }
        
        page += 1
        
        do {
            let response = try await networkManager.request(session: .shared, .allCharacters(page: page), type: CharactersResponse.self)
            self.totalPages = response.info.pages
            self.characters += response.results
            
        } catch {
            self.hasError = true
            if let networkError = error as? NetworkManagerImpl.NetworkError {
                self.error = networkError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    
    func hasReachedEnd(of character: Character) -> Bool {
        characters.last?.id == character.id
    }
}



