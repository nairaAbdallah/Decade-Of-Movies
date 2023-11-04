//
//  PicturesViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit

protocol PicturesProtocol {
    var picturesData: [String] {get}
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
// MARK: - Collection View DataSource
extension PicturesViewModel {
    func getCollectionHeight() -> CGFloat {
        let cellHeight: CGFloat = 342
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
