//
//  RegularCountTests.swift
//  ChallengesTests
//
//  Created by Stefan Blos on 05.03.21.
//

import XCTest

class RegularCountTests: XCTestCase {
    let challenge = Challenge.preview

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        challenge.addToActions(Action.preview)
        XCTAssertEqual(challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!), 20)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
