//
//  MasterTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
    // MARK: - Properties
    var cellTapped: ((_ movie: MasterDataViewModel?) -> Void)?
    var moviesVM: [MasterDataViewModel] = []
    internal lazy var masterVM: MasterSliderViewModel = {
        return MasterSliderViewModel(for: moviesVM)
    }()
    // MARK: - Identifier
    private let masterId = MasterCollectionViewCell.identifier
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCollectionView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
}
// MARK: - SetUp Collection View
extension MasterTableViewCell {
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let adjustForTabbar = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.contentInset = adjustForTabbar
        collectionView.scrollIndicatorInsets = adjustForTabbar
        // Register cells
        collectionView.register(UINib(nibName: masterId, bundle: nil),
                                         forCellWithReuseIdentifier: masterId)
        // casting is required because UICollectionViewLayout doesn't offer header pin.
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        collectionView.semanticContentAttribute = .forceLeftToRight
    }
}
// MARK: - UICollectionViewDataSource
extension MasterTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return masterVM.numOfSections
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return masterVM.numOfItems
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: masterId, for: indexPath)
                as? MasterCollectionViewCell 
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = masterVM.getTitleMovieByRow(for: indexPath)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension MasterTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = masterVM.getMovieByRow(for: indexPath)
        cellTapped?(movie)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return masterVM.minLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return masterVM.minInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return masterVM.sizeForItemAt
    }
}
