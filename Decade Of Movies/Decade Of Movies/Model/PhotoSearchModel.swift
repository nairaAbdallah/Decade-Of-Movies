//
//  PhotoSearchModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import Foundation

class PhotoSearchModel: Codable {
    let photos: PhotosModel?
}

class PhotosModel: Codable {
    let page, pages, perpage, total: Int?
    let photo: [PhotoModel]?
    let stat: String?
}

class PhotoModel: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
}
