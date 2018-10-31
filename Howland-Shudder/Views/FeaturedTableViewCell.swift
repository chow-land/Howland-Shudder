//
//  FeaturedTableViewCell.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/28/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!

    private let cellID = "horizontalCollectionViewCell"

    private let numberTooLargeToScrollThrough = 1000000

    var filmCategory: FilmCategory? {
        didSet {
            categoryLabel.text = filmCategory?.name
            horizontalCollectionView.reloadData()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        filmCategory = nil
        categoryLabel.text = nil
    }


    override func awakeFromNib() {
        super.awakeFromNib()

        horizontalCollectionView.dataSource = self
        horizontalCollectionView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let showLargeImages = filmCategory?.isHero ?? false

        if showLargeImages {
            let midIndexPath = IndexPath(row: numberTooLargeToScrollThrough / 2, section: 0)
            horizontalCollectionView.scrollToItem(at: midIndexPath,
                                                  at: .centeredHorizontally,
                                                  animated: false)
        }

        let heroWidth = Int(window?.bounds.width ?? 1) - 40
        let cellWidth = filmCategory?.isHero ?? false ? heroWidth : 90

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: cellWidth, height: 150)

        horizontalCollectionView.collectionViewLayout = flowLayout
    }


    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let shouldLoop = filmCategory?.isHero ?? false
        let numFilms = filmCategory?.numberOfFilms ?? 0

        return shouldLoop ? numberTooLargeToScrollThrough : numFilms
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CarouselCollectionViewCell

        let numFilms = filmCategory?.numberOfFilms ?? 1
        let loopSafeIndex = indexPath.row % numFilms

        guard
            let filmCategory = filmCategory,
            let film = DataController.shared.getFilm(withID: filmCategory.filmIDs[loopSafeIndex]) else {
                return cell
        }

        if film.isImageBeingFetched {
            return cell
        }

        cell.film = film

        if film.image == nil {
            film.loadImage {
                DispatchQueue.main.async {
                    self.horizontalCollectionView.reloadItems(at: [indexPath])
                }
            }
        }


        return cell
    }
}
