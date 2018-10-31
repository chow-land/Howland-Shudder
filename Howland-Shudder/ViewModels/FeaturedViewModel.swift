//
//  FeaturedViewModel.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/25/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import Foundation

class FeaturedViewModel {
    var numberOfCategories: Int {
        return DataController.shared.filmCategoriesCount
    }

    func getFilmCategories(completion: () -> ()) {
        DataController.shared.fetchCategories {
            completion()
        }
    }

    func filmCategory(forRow row: Int) -> FilmCategory? {
        return DataController.shared.getFilmCategory(forRow: row)
    }
}
