//
//  DetailsViewUITests.swift
//  DecadeOfMoviesUITests
//
//  Created by Naira Bassam on 05/11/2023.
//

import XCTest

final class DetailsViewUITests: XCTestCase {

    
    func testDetailsScrolling() {
        let app = XCUIApplication()
        app.launch()
        let collectionViews = app.collectionViews
        
        let cell = collectionViews.staticTexts["(500) Days of Summer"]
        XCTAssertTrue(cell.exists)
        
        cell.tap()
        
        let tablesQuery = app.tables
        
        tablesQuery.collectionViews
            .children(matching: .cell)
            .element(boundBy: 0)
            .children(matching: .other)
            .element.swipeUp()
        
        tablesQuery.children(matching: .cell)
            .element(boundBy: 6)
            .children(matching: .collectionView)
            .element.swipeUp()
    }
}
