//
//  PhotoSearchViewModel.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 04/11/2023.
//

import Foundation

struct PhotoSearchViewModel {
    let photoURL: String
    init(data: PhotoModel?) {
        let farm = data?.farm ?? 0
        let server = data?.server ?? ""
        let id = data?.id ?? ""
        let secret = data?.secret ?? ""
        self.photoURL = "http://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg"
    }
}
