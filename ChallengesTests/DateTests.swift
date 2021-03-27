//
//  DateTests.swift
//  ChallengesTests
//
//  Created by Stefan Blos on 22.11.20.
//

import XCTest

class DateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfDays() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let date = Date()
        let daysOfWeek = date.daysForWeekBefore
        XCTAssertEqual(7, daysOfWeek.count)
    }
    
    func testIfCurrentDayIsIncluded() throws {
        let date = Date()
        let daysOfWeek = date.daysForWeekBefore
        let startOfDayDate = Calendar.current.startOfDay(for: date)
        
        XCTAssertTrue(daysOfWeek.contains(startOfDayDate), "Current date was not in array of dates")
    }
    
    func testIfOrderOfDaysStartsWithMostBygone() throws {
        let date = Date()
        let daysOfWeek = date.daysForWeekBefore
        
        for (index, day) in daysOfWeek.enumerated() {
            if index > daysOfWeek.count - 2 {
                break
            }
            
            let current = day
            let next = daysOfWeek[index + 1]
            
            XCTAssertTrue(current < next)
        }
    }
    
    func testPreviousDaysForSpecificDate() throws {
        let startDay = 22
        
        guard let startDate = Date.from(day: startDay, month: 10, year: 2020) else { return }
        let daysOfWeek = startDate.daysForWeekBefore
        
        for i in 0 ..< 7 {
            guard let dateToCheck = Date.from(day: startDay - i, month: 10, year: 2020) else { break }
            
            XCTAssertTrue(daysOfWeek.contains(dateToCheck), "\(dateToCheck) was not present in list of days")
        }
        
    }
    
    func testDateStringFormat() throws {
        let date1 = Date.from(day: 22, month: 10, year: 2020)!
        XCTAssertEqual(date1.toDateString, "2020-10-22")
        
        let date2 = Date.from(day: 13, month: 8, year: 2004)!
        XCTAssertEqual(date2.toDateString, "2004-08-13")
        
        let date3 = Date.from(day: 21, month: 6, year: 2017)!
        XCTAssertEqual(date3.toDateString, "2017-06-21")
    }
    
    func testCreateValidDateFromDayMonthYear() throws {
        let validDate = Date.from(day: 20, month: 10, year: 2010)
        XCTAssertNotNil(validDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
