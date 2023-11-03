//
//  NetworkRouter.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit
import Alamofire

enum NetworkRouter: URLRequestConvertible {
    // MARK: - Endpoints
    case search(text: String,
                page: Int,
                perPage: Int)
    // MARK: - Properties
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    var path: String {
        switch self {
        case .search:
            return Config.EndpointPath.search
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .search(let text, let page, let perPage):
            let parameters = [
                "method": "flickr.photos.search",
                "api_key": "207cc8900720b3a7c574df51f898aeb6",
                "format": "json",
                "nojsoncallback": 1,
                "text": text,
                "page": page,
                "per_page": perPage
            ] as [String: Any]
            return parameters
        }
    }
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let endpointPath: String = "\(Config.baseURL)\(path)"
        var components = URLComponents(string: endpointPath)
        var urlRequest = URLRequest(url: (components?.url)!)
        components?.queryItems = []
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}
