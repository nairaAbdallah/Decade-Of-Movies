//
//  DetailsViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import Foundation

protocol DetailsProtocol {
    var updateLoadingStatus: ((_ state: State) -> Void)? { get }
    var reloadTableView: ((_ isHidden: Bool) -> Void)? { get }
    var moviesData: MasterDataViewModel? {get}
}
class DetailsViewModel {
    // MARK: - properties
    var delegate: DetailsProtocol?
    // callback for interfaces
    private var state: State = .empty {
        didSet {
            delegate?.updateLoadingStatus?(state)
        }
    }
    // MARK: - initialization
    init(delegate: DetailsProtocol) {
        self.delegate = delegate
    }
}
// MARK: - SetUpTableView
extension DetailsViewModel {
    var numOfSections: Int {
        return 3
    }
    func getNumOfRow(for section: Int) -> Int {
        return 1
    }
}
// MARK: - Header
extension DetailsViewModel {
    var heightForHeader: CGFloat {
        return 45
    }
//    func getTitleOfHeader(for section: Int) -> String {
//        guard headers.count > section else {return ""}
//        return headers[section]
//    }
}
