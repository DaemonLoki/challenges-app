//
//  WeeklyRepetitionsTests.swift
//  ChallengesTests
//
//  Created by Stefan Blos on 30.03.21.
//

import XCTest

class WeeklyRepetitionsTests: XCTestCase {
    
    func testWeeklyRepetitionsWithOneActionOnSameDayOfWeek() throws {
        let actions: [Action] = [.preview]
        let date = Date.from(day: 22, month: 10, year: 2020)!
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), .PREVIEW_ACTION_COUNT)
    }
    
    func testWeeklyRepetitionsWithOneActionOnOtherDayOfWeek() throws {
        let actions: [Action] = [.preview]
        let date = Date.from(day: 19, month: 10, year: 2020)!
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), .PREVIEW_ACTION_COUNT)
    }
    
    func testWeeklyRepetitionsWithOneActionOnDayOfOtherWeek() throws {
        let actions: [Action] = [.preview]
        let date = Date.from(day: 17, month: 10, year: 2020)!
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), 0)
    }
    
    func testWeeklyRepetitionsWithOneActionOnDayOfOtherMonth() throws {
        let actions: [Action] = [.preview]
        let date = Date.from(day: 19, month: 9, year: 2020)!
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), 0)
    }
    
    func testWeeklyRepetitionsWithMultipleActionsInSameWeek() throws {
        let date = Date.from(day: 19, month: 10, year: 2020)!
        let actions: [Action] = [.preview, .createForPreview(on: date, with: 40), .createForPreview(with: 30)]
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), 90)
    }
    
    func testWeeklyRepetitionsWithMultipleActionsInSameWeek2() throws {
        let date = Date.from(day: 19, month: 10, year: 2020)!
        let actions: [Action] = [.preview, .createForPreview(on: date, with: 10), .createForPreview(with: 10), .createForPreview(on: Date.from(day: 23, month: 10, year: 2020)!, with: 60)]
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), 100)
    }
    
    func testWeeklyRepetitionsWithMultipleActionsInDifferentWeeks() throws {
        let date = Date.from(day: 19, month: 10, year: 2020)!
        let actions: [Action] = [.preview, .createForPreview(on: date, with: 10), .createForPreview(with: 10), .createForPreview(on: Date.from(day: 30, month: 10, year: 2020)!, with: 60)]
        XCTAssertEqual(Challenge.weeklyRepetitions(for: date, in: actions), 40)
    }
}
