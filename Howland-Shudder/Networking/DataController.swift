//
//  DataController.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/25/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import Foundation
// TODO: investigate using CGImage over UIImage. Preferably we don't need to import UIKit at the data/networking layer.
import UIKit

class DataController {
    static let shared = DataController()

    private let jsonDecoder = JSONDecoder()

    // MARK: Film Categories

    private var filmCategories = [FilmCategory]()

    func fetchCategories(completion: () -> ()) {
        guard let path = Bundle.main.path(forResource: "MockCategoriesResponse", ofType: "json") else {
            return
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            self.filmCategories = try jsonDecoder.decode([FilmCategory].self, from: data)
            completion()
        } catch let error {
            // TODO: Show alert dialog to user
            print(error)
        }
    }

    func getFilmCategory(forRow row: Int) -> FilmCategory {
        return filmCategories[row]
    }

    var filmCategoriesCount: Int {
        return filmCategories.count
    }


    // MARK: Films

    private var films = [Int : Film]()

    func getFilm(withID id: Int) -> Film? {
        return films[id]
    }

    func merge(newFilm: Film) {
        // TODO: If we already have the provided film, merge the updated fields of the newFilm into it. This will be important once we're parsing additional Film info from a notional 'GET: film details' endpoint -- For now we'll just add it to the dictionary if we don't already have it.
        guard films[newFilm.id] == nil else {
            return
        }

        films[newFilm.id] = newFilm
    }

    func merge(newFilms: [Film]) {
        for film in newFilms {
            merge(newFilm: film)
        }
    }


    // MARK: Images

    func fetchImage(fromURL url: URL, completion: @escaping (UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    completion(image)
                }
            } else {
                // TODO: handle error states and display appropriate message to user
            }
        }
    }
}
