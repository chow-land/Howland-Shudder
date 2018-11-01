//
//  FilmCategoryTableViewCell.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/28/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class FilmCategoryTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var horizontalCollectionView: UICollectionView!

    var filmCategory: FilmCategory? {
        didSet {
            categoryLabel.text = filmCategory?.name
            horizontalCollectionView.reloadData()
        }
    }

    private let cellID = "horizontalCollectionViewCell"
    private let numberTooLargeToScrollThrough = 1000000
    private let filmCellSize = CGSize(width: 90, height: 150)
    private var filmCellSizeLarge = CGSize(width: 335, height: 150)
    
    private var isHeroRow: Bool {
        return filmCategory?.isHero ?? false
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

        configureCollectionViewLayout()

        let shouldShowLargeImages = filmCategory?.isHero ?? false
        if shouldShowLargeImages {
            scrollToMiddle()
        }
    }

    private func configureCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        flowLayout.itemSize = isHeroRow ? filmCellSizeLarge : filmCellSize

        horizontalCollectionView.collectionViewLayout = flowLayout
    }

    private func scrollToMiddle() {
        guard isHeroRow else {
            return
        }

        let midIndexPath = IndexPath(row: numberTooLargeToScrollThrough / 2, section: 0)
        horizontalCollectionView.scrollToItem(at: midIndexPath,
                                              at: .centeredHorizontally,
                                              animated: false)
    }


    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let shouldLoop = isHeroRow
        let numFilms = filmCategory?.numberOfFilms ?? 0

        return shouldLoop ? numberTooLargeToScrollThrough : numFilms
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = horizontalCollectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HorizontalCollectionViewCell

        let numFilms = filmCategory?.numberOfFilms ?? 1
        let loopSafeIndex = indexPath.row % numFilms

        guard
            let filmCategory = filmCategory,
            let film = DataController.shared.getFilm(withID: filmCategory.filmIDs[loopSafeIndex]) else {
                return cell
        }

        cell.configureWithFilm(film: film)

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
