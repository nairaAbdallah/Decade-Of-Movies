//
//  PicturesCollectionViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit
import Kingfisher

class PicturesCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var picture: String = "" {
        didSet {
            if let url = URL(string: picture) {
                self.moviePicture.kf.setImage(with: url, placeholder: UIImage(named: "placeHolder"))
            } else {
                self.moviePicture.image = UIImage(named: "placeHolder")
            }
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var moviePicture: UIImageView!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
