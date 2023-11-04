//
//  MasterViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import Foundation

protocol MasterProtocol {
    var updateLoadingStatus: ((_ state: State) -> Void)? { get }
    var reloadTableView: ((_ isHidden: Bool) -> Void)? { get }
}

class MasterViewModel {
    // MARK: - properties
    var delegate: MasterProtocol?
    private let headers = ["Top Rated", "Most Recent",
                           "Action", "Family",
                           "Comedy", "All Categories"]
    // MARK: - DataViewModel
    private var masterDataVM: [MasterDataViewModel] = [] {
        didSet {
            categoriesMovies()
        }
    }
    var categories: [[MasterDataViewModel]] = [] {
        didSet {
            delegate?.reloadTableView?(false)
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
// MARK: - SetUpTableView
extension MasterViewModel {
    var numOfSections: Int {
        return 6
    }
    func getNumOfRow(for section: Int) -> Int {
        guard categories.count > section else {return 0}
        return 1
    }
    func getCategoryByRow(for indexPath: IndexPath) -> [MasterDataViewModel] {
        guard categories.count > indexPath.section else {return []}
        return categories[indexPath.section]
    }
}
// MARK: - Header
extension MasterViewModel {
    var heightForHeader: CGFloat {
        return 45
    }
    func getTitleOfHeader(for section: Int) -> String {
        guard headers.count > section else {return ""}
        return headers[section]
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
// MARK: - Categories Movies
extension MasterViewModel {
    private func categoriesMovies() {
        let topRated = masterDataVM.filter{$0.rating == 5}
        let mostRecent = masterDataVM.filter{$0.year > 2017}
        let action = masterDataVM.filter{$0.genres.contains("Action")}
        let family = masterDataVM.filter{$0.genres.contains("Family")}
        let comedy = masterDataVM.filter{$0.genres.contains("Comedy")}
        categories = [topRated, mostRecent, action, family, comedy, masterDataVM]
    }
}
