//
//  RegularCountTests.swift
//  ChallengesTests
//
//  Created by Stefan Blos on 05.03.21.
//

import XCTest

class DailyRepetitionsTests: XCTestCase {

    func testDailyRepetitionsWithOneAction() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions: [Action] = [.preview]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), .PREVIEW_ACTION_COUNT)
    }

    func testDailyRepetitionsWithTwoActions() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions: [Action] = [.preview, .createForPreview(with: 40)]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), .PREVIEW_ACTION_COUNT + 40)
    }
    
    func testDailyRepetitionsWithManyActions() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions: [Action] = [.preview, .preview, .createForPreview(with: 80), .createForPreview(with: 10)]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), 130)
    }
    
    func testDailyRepetitionsWithOneActionOnDifferentDay() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions: [Action] = [.createForPreview(on: Date.from(day: 21, month: 10, year: 2020)!, with: 20)]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), 0)
    }
    
    func testDailyRepetitionsWithMultipleActionsOnDifferentDays() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let actions: [Action] = [.preview, .createForPreview(on: Date.from(day: 21, month: 10, year: 2020)!, with: 20), .createForPreview(on: Date.from(day: 23, month: 11, year: 2021)!, with: 10), .createForPreview(on: Date.from(day: 22, month: 10, year: 2020)!, with: 30)]
        XCTAssertEqual(Challenge.dailyRepetitions(for: Date.from(day: 22, month: 10, year: 2020)!, in: actions), 50)
    }

}
