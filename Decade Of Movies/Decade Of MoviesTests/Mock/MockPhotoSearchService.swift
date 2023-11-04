//
//  MockPhotoSearchService.swift
//  Decade Of MoviesTests
//
//  Created by Naira Bassam on 04/11/2023.
//

import Foundation
import Alamofire
@testable import Decade_Of_Movies

class MockPhotoSearchService: PhotoSearchService {
    func getPhotoSearch(text: String, completion: @escaping (AFResult<PhotoSearchModel>) -> Void) {
        guard let jsonData = readPhotosLocalJSONFile() else {
            return
        }
        do {
            let obiect = try JSONDecoder().decode(PhotoSearchModel.self, from: jsonData)
            completion(.success(obiect))
        } catch let error {
            print(error)
            let error = AFError.sessionTaskFailed(error: URLError(.cannotDecodeContentData))
            completion(.failure(error))
        }
    }
    
    private func readPhotosLocalJSONFile() -> Data? {
        do {
            guard let fileUrl = Bundle.main.url(forResource: "photos", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: fileUrl)
            return data
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
