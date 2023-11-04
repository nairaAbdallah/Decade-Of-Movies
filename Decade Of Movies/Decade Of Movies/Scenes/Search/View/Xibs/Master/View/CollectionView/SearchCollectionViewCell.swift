//
//  SearchCollectionViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var title: String = "" {
        didSet {
            movieTitle.text = title
        }
    }
    // MARK: - IBOutlet
    @IBOutlet weak var movieTitle: UILabel!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
