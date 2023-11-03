//
//  MovieModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import Foundation

struct MovieModel: Codable {
    var movies: [MovieDataModel]
    // MARK: - Initialization
    init?(jsonString: String) {
        guard let data = jsonString.data(using: .utf8) else {
            return nil
        }
        guard let object = MovieModel(data: data) else {
            return nil
        }
        self = object
    }
    init?(data: Data) {
        guard let object = try? JSONDecoder().decode(MovieModel.self, from:
                                                        data) else {
            return nil
        }
        self = object
    }
}

struct MovieDataModel: Codable {
    var title: String
    var year, rating: Int
    var cast, genres: [String]
}
