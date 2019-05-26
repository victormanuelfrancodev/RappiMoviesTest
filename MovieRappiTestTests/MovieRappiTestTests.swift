//
//  MovieRappiTestTests.swift
//  MovieRappiTestTests
//
//  Created by Victor Manuel Lagunas Franco on 5/21/19.
//  Copyright © 2019 Victor Manuel Lagunas Franco. All rights reserved.
//

@testable import MovieRappiTest
import XCTest


class MovieRappiTestTests: XCTestCase {
    
    override func setUp() {
        language()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetListPopularMovies(){
        let e = expectation(description: "Moviewmanager")
        Moviewmanager.fetchPopularMovie(completion: { results, error in
            print(error.debugDescription)
            if error == nil {
                //XCTAssertNil(results)
                XCTAssertNotNil(results, "Expected non-nil")
                e.fulfill()
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetListTopRankedMovies(){
         let e = expectation(description: "Moviewmanager")
        Moviewmanager.fetchTopRankedMovie(completion: { results, error in
            if error == nil {
                if let results = results {
                    //XCTAssertNil(results)
                    XCTAssertNotNil(results, "Expected non-nil")
                    e.fulfill()
                }
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetListUpCommingMovies(){
        let e = expectation(description: "Moviewmanager")
        Moviewmanager.fetchUpcoming(completion: { results, error in
            if error == nil {
                if let results = results {
                    //XCTAssertNil(results)
                    XCTAssertNotNil(results, "Expected non-nil")
                    e.fulfill()
                }
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetVideos(){
        let e = expectation(description: "VideoManager")
        let request = Videos.Fetch.Request(idMovie: "458156")
        //let request = Videos.Fetch.Request(idMovie: "test")
        VideoManager.fetchVideos(request: request, completion: { results, error in
            if error == nil {
                if let results = results {
                    XCTAssertNotNil(results, "Expected non-nil")
                    if let videos = results.videos {
                       // XCTAssertGreaterThan(videos.count, 10)
                    }
                     e.fulfill()
                }
            }
        })
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func language(){
        // XCTAssertEqual(Locale.preferredLanguageIdentifier, "es-ES")
        //en-US
         XCTAssertEqual(Locale.preferredLanguageIdentifier, "en-US")
    }
}
