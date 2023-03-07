//
//  EpisodeResponseModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/3/23.
//

import Foundation

struct EpisodesResponse: Codable {
    let info: Info
    let results: [Episode]
}

struct Episode: Identifiable, Codable {
    var id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
}

var episodeDummyData = Episode(id: 1, name: "Pilot", airDate: "December 2, 2013", episode: "S01E01", characters: [
    "https://rickandmortyapi.com/api/character/1",
    "https://rickandmortyapi.com/api/character/2"
], url: "https://rickandmortyapi.com/api/location/1")
