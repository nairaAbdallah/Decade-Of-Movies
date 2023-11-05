//
//  PicturesTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

class PicturesTableViewCell: UITableViewCell {
    // MARK: - Properties
    var pictures: [String] = [] {
        didSet {
            setupCollectionView()
        }
    }
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
        setupCollectionView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
// MARK: - SetUp Collection View
extension PicturesTableViewCell {
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionHeight.constant = picturesVM.getCollectionHeight()
        let adjustForTabbarInsets = picturesVM.adjustForTabbar
        collectionView.contentInset = adjustForTabbarInsets
        collectionView.scrollIndicatorInsets = adjustForTabbarInsets
        // Register cells
        collectionView.register(UINib(nibName: picturesId,
                                               bundle: nil),
                                         forCellWithReuseIdentifier: picturesId)
        // casting is required because UICollectionViewLayout doesn't offer header pin.
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        collectionView.reloadData()
    }
}
// MARK: - Collection View DataSource
extension PicturesTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return picturesVM.numOfSections
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return picturesVM.numOfItems
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picturesId,
                                                            for: indexPath)
                as? PicturesCollectionViewCell else {
            fatalError("Cell not exists in cell")
        }
        cell.picture = picturesVM.getPictureByRow(for: indexPath)
        return cell
    }
}
// MARK: - Collection View Delegate
extension PicturesTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return picturesVM.insetForSection
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return picturesVM.minLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return picturesVM.minInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return picturesVM.sizeForItemAt
    }
}
// MARK: - Implement protocol
extension PicturesTableViewCell: PicturesProtocol {
    var picturesData: [String] {
        return pictures
    }
}
