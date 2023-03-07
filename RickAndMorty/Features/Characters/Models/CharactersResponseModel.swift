//
//  CharactersResponseModel.swift
//  RickAndMorty
//
//  Created by Doni on 2/26/23.
//

import Foundation

struct CharactersResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    let name: String
    let status: Status
    let type: String
    let species: String
    let gender: Gender
    let location: OriginOrLocation
    let origin: OriginOrLocation
    let image: String
    let episode: [String]
    let url: String
}

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum Gender: String, Codable {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}

struct OriginOrLocation: Codable {
    let name: String
    let url: String
}

var characterDummyData = Character(id: 1, name: "Morty Smith", status: .alive, type: "", species: "Human", gender: .male, location: OriginOrLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/20"), origin: OriginOrLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/1"), image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1","https://rickandmortyapi.com/api/episode/2",], url: "https://rickandmortyapi.com/api/character/2")

