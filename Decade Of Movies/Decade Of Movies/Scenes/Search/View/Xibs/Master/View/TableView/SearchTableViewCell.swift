//
//  SearchTableViewCell.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    // MARK: - Properties
    var cellTapped: ((_ movie: MasterDataViewModel?) -> Void)?
    var moviesVM: [MasterDataViewModel] = [] {
        didSet {
            // ReInitialize ViewModel for search screen to update data on it
            searchVM = SearchSliderViewModel(for: moviesVM)
            collectionView.reloadData()
        }
    }
    internal lazy var searchVM: SearchSliderViewModel = {
        return SearchSliderViewModel(for: moviesVM)
    }()
    // MARK: - Identifier
    private let masterId = SearchCollectionViewCell.identifier
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
extension SearchTableViewCell {
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
extension SearchTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchVM.numOfSections
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchVM.numOfItems
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: masterId, for: indexPath)
                as? SearchCollectionViewCell 
        else {
            fatalError("Cell not exists in cell")
        }
        cell.title = searchVM.getTitleMovieByRow(for: indexPath)
        return cell
    }
}
// MARK: - UICollectionViewDelegate
extension SearchTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = searchVM.getMovieByRow(for: indexPath)
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
        return searchVM.minLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return searchVM.minInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return searchVM.sizeForItemAt
    }
}
