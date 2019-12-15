//
//  ScorerTests.swift
//  ScorerTests
//
//  Created by Nobuhiro Harada on 2019/11/02.
//  Copyright © 2019 Nobuhiro Harada. All rights reserved.
//

import XCTest
@testable import Scorer

class ScorerTests: XCTestCase {

    var team: Team!
    
    override func setUp() {
        team = Team(name: "", score: 0)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let resultIncrement = team.incrementScore(score: 10)
        XCTAssertEqual(11, resultIncrement)
        
        let resultDecrement = team.decrementScore(score: 10)
        XCTAssertEqual(9, resultDecrement)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
