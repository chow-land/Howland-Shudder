//
//  Film.swift
//  Howland-Shudder
//
//  Created by Christian Howland on 10/24/18.
//  Copyright © 2018 Christian Howland. All rights reserved.
//

import Foundation
import UIKit

class Film: Decodable {
    let id: Int
    let tileImageURL: URL

    let tileBackgroundColor: UIColor = .orange
    var image: UIImage? = nil

    var isImageBeingFetched = false
    
    func loadImage(completion: @escaping () -> ()) {
        guard image == nil && !isImageBeingFetched else {
            return
        }

        isImageBeingFetched = true
        DataController.shared.fetchImage(fromURL: tileImageURL) {
            self.image = $0
            self.isImageBeingFetched = false
            completion()
        }
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(Int.self, forKey: .id)
        tileImageURL = try values.decode(URL.self, forKey: .tileImageURL)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case tileImageURL
    }
}
