//
//  PicturesViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

protocol PicturesProtocol {
    var picturesData: [PhotoSearchViewModel] {get}
}
class PicturesViewModel {
    // MARK: - properties
    private let screenWidth = UIScreen.main.bounds.width
    private var delegate: PicturesProtocol?
    // MARK: - initialization
    init(delegate: PicturesProtocol) {
        self.delegate = delegate
    }
}
// MARK: - Get Picture by row
extension PicturesViewModel {
    func getPictureByRow(for indexPath: IndexPath) -> String {
        let pictures = delegate?.picturesData ?? []
        guard pictures.count > indexPath.row else {return ""}
        return pictures[indexPath.row].photoURL
    }
}
// MARK: - Collection View DataSource
extension PicturesViewModel {
    func getCollectionHeight() -> CGFloat {
        let cellHeight: CGFloat = 200
        let numOfRows: CGFloat = CGFloat(numOfItems%2 + numOfItems/2)
        let cellsHeight = numOfRows * cellHeight
        let addSeperatedSpaces = (numOfRows - 1)*20
        return cellsHeight + addSeperatedSpaces
    }
    var numOfSections: Int {
        return 1
    }
    var numOfItems: Int {
        return (delegate?.picturesData ?? []).count
    }
}
// MARK: - Collection View Delegate
extension PicturesViewModel {
    var adjustForTabbar: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    var insetForSection: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    var sizeForItemAt: CGSize {
        let width = (screenWidth/2)-30
        return CGSize(width: width, height: 200)
    }
    var minLineSpacing: CGFloat {
        return 20
    }
    var minInteritemSpacing: CGFloat {
        return 20
    }
}
