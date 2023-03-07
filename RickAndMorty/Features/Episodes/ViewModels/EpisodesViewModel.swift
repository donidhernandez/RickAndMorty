//
//  EpisodesViewModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/3/23.
//

import Foundation

final class EpisodesViewModel: ObservableObject {
    @Published private(set) var episodes: [Episode] = []
    @Published private(set) var error: NetworkManagerImpl.NetworkError?
    @Published private(set) var episodeDetail: Episode!
    @Published var hasError = false
    
    private(set) var page = 1
    private(set) var totalPages: Int?
    
    private let networkManager: NetworkManager!
    
    init(networkManager: NetworkManager = NetworkManagerImpl.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getAllEpisodes() async {
        do{
            let response = try await networkManager.request(session: .shared, .allEpisodes(page: page), type: EpisodesResponse.self)
            self.episodes = response.results
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
    func getNextSetOfEpisodes() async {
        guard page != totalPages else { return }
        
        page += 1
        
        do {
            let response = try await networkManager.request(session: .shared, .allEpisodes(page: page), type: EpisodesResponse.self)
            self.totalPages = response.info.pages
            self.episodes += response.results
            
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
    func getSingleEpisode(id: Int) async {
        do {
            let response = try await networkManager.request(session: .shared, .singleEpisode(id: id), type: Episode.self)
            self.episodeDetail = response
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
    func getEpisodeCharacters(episode: Episode) async -> [Character] {
        var characters: [Character] = []
        try? await episode.characters.asyncForEach { characterURL in
            let splittedURL = characterURL.split(separator: "/")
            let id = Int(splittedURL.last ?? "1")!
            let response = try await networkManager.request(session: .shared, .singleCharacter(id: id), type: Character.self)
            characters.append(response)
        }
        
        return characters
    }
    
    func hasReachedEnd(of episode: Episode) -> Bool {
        episodes.last?.id == episode.id
    }
}


