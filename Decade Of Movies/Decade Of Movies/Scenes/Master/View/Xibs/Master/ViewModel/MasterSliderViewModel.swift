//
//  MasterSliderViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import Foundation

class MasterSliderViewModel {
    // MARK: - properties
    var movies: [MasterDataViewModel]
    // MARK: - initialization
    init(for movies: [MasterDataViewModel]) {
        self.movies = movies
    }
    // MARK: - Get data by row
    func getMovieByRow(for indexPath: IndexPath) -> MasterDataViewModel? {
        guard movies.count > indexPath.row else {return nil}
        return movies[indexPath.row]
    }
    func getTitleMovieByRow(for indexPath: IndexPath) -> String {
        return getMovieByRow(for: indexPath)?.title ?? ""
    }
}
// MARK: - CollectionViewDataSource
extension MasterSliderViewModel {
    var numOfSections: Int {
        return 1
    }
    var numOfItems: Int {
        return movies.count
    }
}
// MARK: - CollectionViewDelegate
extension MasterSliderViewModel {
    var sizeForItemAt: CGSize {
        return CGSize(width: 160, height: 90)
    }
    var minLineSpacing: CGFloat {
        return 12
    }
    var minInteritemSpacing: CGFloat {
        return 12
    }
}
