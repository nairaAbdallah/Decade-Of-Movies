//
//  NetworkService.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit
import Alamofire

protocol NetworkServiceProtocol {
    @discardableResult
    func performRequest<T: Decodable>(route: NetworkRouter,
                                      completion: @escaping (AFResult<T>) -> Void)
    -> DataRequest
}

class NetworkService: NetworkServiceProtocol {

    func isNetworkReachable() -> Bool {
        guard let networkManager = NetworkReachabilityManager() else {
            return false
        }
        
        return networkManager.isReachable
    }
    
    @discardableResult
    func performRequest<T: Decodable>(route: NetworkRouter,
                                      completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        guard isNetworkReachable()
        else {
            let error = AFError.sessionTaskFailed(error: URLError(.notConnectedToInternet))
            completion(.failure(error))
            return AF.request(route)
        }
        
        return AF.request(route).responseDecodable { (response: DataResponse<T, AFError>) in
            completion(response.result)
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }
        }
    }
}
