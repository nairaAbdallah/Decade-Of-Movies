//
//  MasterCollectionViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

class MasterCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    var movieVM: MasterDataViewModel? {
        didSet {
            movieTitle.text = movieVM?.title ?? ""
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
