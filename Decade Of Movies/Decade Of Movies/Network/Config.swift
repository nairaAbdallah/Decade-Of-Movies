//
//  Config.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import Foundation
import NVActivityIndicatorView

struct Config {
    static let baseURL: String = "https://api.flickr.com/"
    struct EndpointPath {
        static let search = "services/rest/"
    }
}
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case json = "application/json"
    case urlEncode = "application/x-www-form-urlencoded; charset=UTF-8"
}
var indicator = NVActivityIndicatorView(frame: .zero)
