//
//  HorizontalCollectionViewCell
//  Howland-Shudder
//
//  Created by Christian Howland on 10/24/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var filmImageView: UIImageView!

    private var loadingSpinner = UIActivityIndicatorView(style: .white)

    func configureWithFilm(film: Film) {
        if let image = film.image {
            filmImageView.image = image
            loadingSpinner.stopAnimating()
        } else {
            filmImageView.backgroundColor = film.tileBackgroundColor
            loadingSpinner.startAnimating()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        configureCellStyles()
        addSubview(loadingSpinner)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        loadingSpinner.frame = self.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        filmImageView.image = nil
    }

    private func configureCellStyles() {
        // rounded corners
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 0.25
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true

        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 10, height: 10.0)
        layer.shadowRadius = 6
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
}
