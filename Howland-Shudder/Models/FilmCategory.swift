//
//  FilmCategory.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/25/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import Foundation

class FilmCategory: Decodable {
    let name: String?
    let isHero: Bool
    let filmIDs: [Int]

    var numberOfFilms: Int {
        return filmIDs.count
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        isHero = try values.decode(Bool.self, forKey: .isHero)
        let films = try values.decode([Film].self, forKey: .films)
        filmIDs = films.compactMap { $0.id }

        DataController.shared.merge(newFilms: films)
    }

    private enum CodingKeys: String, CodingKey {
        case name
        case isHero
        case films
    }
}
