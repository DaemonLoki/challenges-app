//
//  RegularCountTests.swift
//  ChallengesTests
//
//  Created by Stefan Blos on 05.03.21.
//

import XCTest

class RegularCountTests: XCTestCase {

    func testDailyWithOneAction() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions = [Action.preview]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), 20)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
