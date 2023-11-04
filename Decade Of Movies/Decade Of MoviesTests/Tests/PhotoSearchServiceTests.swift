//
//  PhotoSearchServiceTests.swift
//  Decade Of MoviesTests
//
//  Created by Naira Bassam on 04/11/2023.
//

import XCTest
@testable import Decade_Of_Movies

final class PhotoSearchServiceTests: XCTestCase {
    override func setUp() {
    }
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    override func tearDownWithError() throws {
    }

    // MARK: - PhotoSearchServiceTests Methods
    func testPhotoSearchService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Arrange
        let sut = DetailsViewModel(apiService: MockPhotoSearchService(), delegate: nil)
        let expectation = self.expectation(description: "PhotoSearch Service Response Expectation")
        // Act
        sut.fetchPhotos()
        expectation.fulfill()
        // Assert
        XCTAssertEqual(sut.photosVM.count, 10)
        self.wait(for: [expectation], timeout: 10)

    }
}
