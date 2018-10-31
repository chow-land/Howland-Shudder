//
//  CarouselCollectionViewCell.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/24/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var filmImageView: UIImageView!

    private var loadingSpinner = UIActivityIndicatorView(style: .white)

    var film: Film? {
        didSet {
            if let image = film?.image {
                filmImageView.image = image
                hideLoadingSpinner()
            } else {
                filmImageView.backgroundColor = film?.bgColor
                showLoadingSpinner()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        layer.masksToBounds = true
        layer.cornerRadius = 6

        addSubview(loadingSpinner)
//        self.loadingSpinner.frame = self.bounds
//        showLoadingSpinner()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.loadingSpinner.frame = self.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        film = nil
        filmImageView.image = nil
    }

    private func showLoadingSpinner() {
        guard !loadingSpinner.isAnimating else {
            return
        }

        self.loadingSpinner.startAnimating()
    }

    private func hideLoadingSpinner() {
        guard !loadingSpinner.isAnimating else {
            return
        }

        self.loadingSpinner.stopAnimating()
    }
}
