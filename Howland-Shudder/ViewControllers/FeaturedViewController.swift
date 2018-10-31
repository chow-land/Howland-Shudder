//
//  FeaturedViewController.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/23/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class FeaturedViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var filmCategoriesTableView: UITableView!

    private let cellID = "filmCategoryTableViewCell"
    private let viewModel = FeaturedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        filmCategoriesTableView.dataSource = self

        viewModel.getFilmCategories {
            DispatchQueue.main.async {
                self.filmCategoriesTableView.reloadData()
            }
        }
    }

    // MARK:  UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filmCategoriesTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FilmCategoryTableViewCell

        cell.filmCategory = viewModel.filmCategory(forRow: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCategories
    }
}
