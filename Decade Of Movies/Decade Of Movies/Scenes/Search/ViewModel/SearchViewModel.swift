//
//  SearchViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import Foundation
import OrderedCollections

protocol SearchProtocol {
    var updateLoadingStatus: ((_ state: State) -> Void)? { get }
    var reloadTableView: ((_ isHidden: Bool) -> Void)? { get }
}

class SearchViewModel {
    // MARK: - properties
    var delegate: SearchProtocol?
    // MARK: - DataViewModel
    private var moviesRowData: [MasterDataViewModel] = []
    private var moviesDataVM: [MasterDataViewModel] = [] {
        didSet {
            getGroupedData()
        }
    }
    var moviesDictionary: OrderedDictionary<Int, [MasterDataViewModel]> = [:] {
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
    init(delegate: SearchProtocol) {
        self.delegate = delegate
    }
}
// MARK: - SetUpTableView
extension SearchViewModel {
    var numOfSections: Int {
        return moviesDictionary.count
    }
    func getNumOfRow(for section: Int) -> Int {
        return 1
    }
}
// MARK: - Header
extension SearchViewModel {
    var heightForHeader: CGFloat {
        return 45
    }
    func getTitleOfHeader(for section: Int) -> String {
        guard moviesDictionary.count > section else {return ""}
        return "\(moviesDictionary.keys[section])"
    }
}
// MARK: - Get Movies
extension SearchViewModel {
    func getMovies() {
        state = .loading
        let path = Bundle.main.path(forResource: "movies", ofType: "json") ?? ""
        do {
            let string = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            let data = MovieModel(jsonString: string)
            moviesRowData = data?.movies?.compactMap {MasterDataViewModel(data: $0) } ?? []
            moviesDataVM = moviesRowData
        }
        catch {
            state = .error
        }
    }
    private func getGroupedData() {
        var dictionary = OrderedDictionary(grouping: moviesDataVM) { $0.year }
        dictionary = dictionary.mapValues { Array($0.sorted(by: { $0.rating > $1.rating }).prefix(5))}
        moviesDictionary = dictionary
    }
}
// MARK: - Filter Movies
extension SearchViewModel {
    func filterMovies(for search: String) {      
        moviesDataVM = !search.isEmpty ? moviesRowData.filter { $0.title.contains(search) } : moviesRowData
    }
}
// MARK: - get Movies for section
extension SearchViewModel {
    func getMoviesBySection(for indexPath: IndexPath) -> [MasterDataViewModel] {
        let movies = moviesDictionary.values
        guard movies.count > indexPath.section else {return []}
        return movies[indexPath.section]
    }
}
