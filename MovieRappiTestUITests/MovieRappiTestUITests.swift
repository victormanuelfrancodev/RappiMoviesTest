//
//  MovieRappiTestUITests.swift
//  MovieRappiTestUITests
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

import XCTest

class MovieRappiTestUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
