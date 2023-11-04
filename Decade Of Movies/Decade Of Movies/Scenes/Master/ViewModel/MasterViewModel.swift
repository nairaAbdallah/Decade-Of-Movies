//
//  MasterViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

protocol MasterProtocol {
    var updateLoadingStatus: ((_ state: State) -> Void)? { get }
    var reloadCollectionView: ((_ isHidden: Bool) -> Void)? { get }
}

class MasterViewModel {
    // MARK: - properties
    private let screenWidth = UIScreen.main.bounds.width
    var delegate: MasterProtocol?
    // MARK: - DataViewModel
    private var masterDataVM: [MasterDataViewModel] = [] {
        didSet {
            delegate?.reloadCollectionView?(false)
            state = .populated
        }
    }
    // callback for interfaces
    private var state: State = .empty {
        didSet {
            delegate?.updateLoadingStatus?(state)
        }
    }
    // MARK: - initialization
    init(delegate: MasterProtocol) {
        self.delegate = delegate
    }
}
// MARK: - UICollectionViewDataSource
extension MasterViewModel {
    var adjustTabBar: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
    var numOfSections: Int {
        return 1
    }
    var numOfItemsInSection: Int {
        return masterDataVM.count
    }
    func getCategoryByRow(for indexPath: IndexPath) -> MasterDataViewModel? {
        guard masterDataVM.count > indexPath.row else {return nil}
        return masterDataVM[indexPath.row]
    }
}
// MARK: - UICollectionViewDelegate
extension MasterViewModel {
    var cellSize: CGSize {
        let midScreen = screenWidth/2
        return CGSize(width: midScreen-24, height: 200)
    }
    var lineSpace: CGFloat {
        return 16
    }
}
// MARK: - Get Movies
extension MasterViewModel {
    func getMovies() {
        state = .loading
        let path = Bundle.main.path(forResource: "movies", ofType: "json") ?? ""
        do {
            let string = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let data = MovieModel(jsonString: string)
            masterDataVM = data?.movies?.compactMap {MasterDataViewModel(data: $0) } ?? []
        }
        catch {
            state = .error
        }
    }
}
