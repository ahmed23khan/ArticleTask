//
//  ArticlesTests.swift
//  ArticlesTests
//
//  Created by Tauqeer Ahmed Khan on 11/11/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import XCTest
@testable import Articles

class ArticlesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let fetchExpectation = self.expectation(description: "Fetch Articles")
            
            ArticleManager.defaultManager.fetchMostPopularArticles { (articles, error) in
                XCTAssertTrue((articles?.count != 0), "Failed to fetch Articles")
                fetchExpectation.fulfill()
            }
            self.wait(for: [fetchExpectation], timeout: 10000)
        }
    }
}
