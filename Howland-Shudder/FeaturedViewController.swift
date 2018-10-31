//
//  ViewController.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/23/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var filmCategoriesTableView: UITableView!

    private let cellID = "filmCategoriesTableViewCell"

    let viewModel = FeaturedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        filmCategoriesTableView.dataSource = self
        filmCategoriesTableView.delegate = self

        viewModel.getFilmCategories {
            DispatchQueue.main.async {
                self.filmCategoriesTableView.reloadData()
            }
        }
    }

    // MARK:  UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filmCategoriesTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FeaturedTableViewCell

        cell.filmCategory = viewModel.filmCategory(forRow: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories
    }

    // MARK: UITableViewDelegate

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        guard let category = viewModel.category(forRow: indexPath.row) else {
////            return 80//TODO - what's the right defaultot use?
////        }
////
////        return 80
//
//        // TODO: decide how to hangle image size variation
//
////        switch category.carouselStyle {
////        case .large:
////            return 80
////        default:
////            return 40
////        }
//    }

}
