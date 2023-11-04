//
//  PicturesTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

class PicturesTableViewCell: UITableViewCell {
    // MARK: - Properties
    var pictures: [String] = []
    lazy private var picturesVM: PicturesViewModel = {
        return PicturesViewModel(delegate: self)
    }()
    // MARK: - Identifier
    private let picturesId = PicturesCollectionViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
// MARK: - Implement protocol
extension PicturesTableViewCell: PicturesProtocol {
    var picturesData: [String] {
        return pictures
    }
    
    
}
