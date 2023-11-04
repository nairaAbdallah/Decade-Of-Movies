//
//  DetailsService.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import UIKit
import Alamofire

protocol PhotoSearchService {
    func getPhotoSearch(text: String,
                        completion: @escaping (AFResult<PhotoSearchModel>) -> Void)
}

class PhotoSearchServiceImpl: PhotoSearchService {
    private let service = NetworkService()
    func getPhotoSearch(text: String,
                        completion: @escaping (AFResult<PhotoSearchModel>) -> Void) {
        service.performRequest(route: .search(text: text),
                               completion: completion)
    }
}
