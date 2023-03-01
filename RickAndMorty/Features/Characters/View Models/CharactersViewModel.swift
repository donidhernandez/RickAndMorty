//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/1/23.
//

import Foundation

final class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func getAllCharacters() async throws {
        let url = URL(string: "\(baseURL)/character")!
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidStatusCode
            }
            
            let decoder = JSONDecoder()
            guard let charactersResponse = try? decoder.decode(CharactersResponse.self, from: data) else {
                throw NetworkError.decodingError
            }
            
            self.characters = charactersResponse.results
        } catch {
            print(error)
        }
    }
}
