//
//  InfoModel.swift
//  RickAndMorty
//
//  Created by Doni on 3/3/23.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
