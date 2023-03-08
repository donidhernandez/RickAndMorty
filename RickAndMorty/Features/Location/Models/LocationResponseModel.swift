//
//  LocationResponseModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/7/23.
//

import Foundation

struct LocationsResponse: Codable {
    let info: Info
    let results: [Location]
}

struct Location: Identifiable, Codable {
    var id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
}

var locationDummyData = Location(id: 1, name: "Earth",
                                 type: "Earth",
                                 dimension: "Dimension C-137",
                                 residents: [
                                    "https://rickandmortyapi.com/api/character/1",
                                    "https://rickandmortyapi.com/api/character/2"],
                                 url: "https://rickandmortyapi.com/api/location/1")
