//
//  MasterViewUITests.swift
//  DecadeOfMoviesUITests
//
//  Created by Naira Bassam on 05/11/2023.
//

import XCTest

final class MasterViewUITests: XCTestCase {

    func testMasterCollectionView_ScrollingBehavior() {
        let app = XCUIApplication()
        app.launch()
        let masterCollectionView = app.collectionViews.children(matching: .cell)
        XCTAssertTrue(masterCollectionView.count > 0)
        
        let cell = masterCollectionView.element(boundBy: 4)
        cell.children(matching: .other).element.children(matching: .other).element.swipeUp()
        cell.staticTexts["Movie Title:"].swipeUp()
    }
    
    func testMasterCollectionView_Tap_NavigateToDetails() {
        let app = XCUIApplication()
        app.launch()
        let collectionViews = app.collectionViews
        
        let cell = collectionViews.staticTexts["(500) Days of Summer"]
        XCTAssertTrue(cell.exists)
        
        cell.tap()
    }
    
    func testMasterSecreen_Tap_Search() {
        let app = XCUIApplication()
        app.launch()
        
        let searchButton = app.buttons["search"]
        XCTAssertTrue(searchButton.exists)
        
        searchButton.tap()
    }
}
