//
//  MasterDataViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import Foundation

struct MasterDataViewModel {
    var title: String
    var year, rating: Int
    var cast, genres: [String]
    init(data: MovieDataModel?) {
        self.title = data?.title ?? ""
        self.year = data?.year ?? 0
        self.rating = data?.rating ?? 0
        self.cast = data?.cast ?? []
        self.genres = data?.genres ?? []
    }
}
