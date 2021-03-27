//
//  Challenge+UIProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 12.12.20.
//

import Foundation
import CoreGraphics

extension Challenge {
    
    static func dailyRepetitions(for date: Date, in actions: [Action]) -> Double {
        return actions
            .filter { $0.unwrappedDate.toDateString == date.toDateString }
            .map { $0.count }
            .reduce(0.0, +)
    }
        
    func weeklyRepetitions(for date: Date) -> Double {
        return repetitions(for: date, of: .weekOfYear)
    }
    
    func monthlyRepetitions(for date: Date) -> Double {
        return repetitions(for: date, of: .month)
    }
    
    func yearlyRepetitions(for date: Date) -> Double {
        return repetitions(for: date, of: .year)
    }
    
    private func repetitions(for date: Date, of repetitionType: Calendar.Component) -> Double {
        let calendar = Calendar.current
        let currentUnit = calendar.component(repetitionType, from: date)
        let currentYear = calendar.component(.year, from: date)
        
        return actionsArray.filter { (action: Action) -> Bool in
            let dateUnit = calendar.component(repetitionType, from: action.unwrappedDate)
            let dateYear = calendar.component(.year, from: action.unwrappedDate)
            return dateUnit == currentUnit && dateYear == currentYear
        }
        .map { $0.count }
        .reduce(0.0, +)
    }
    
    
    
    var totalCount: Double {
        return actionsArray
            .map { $0.count }
            .reduce(0.0, +)
    }
    
    func heightOfBar(for date: Date, with maxHeight: CGFloat) -> CGFloat {
        let percentage = Challenge.dailyRepetitions(for: date, in: actionsArray) / (regularGoal == 0 ? 1 : regularGoal)
        let goalHeight = maxHeight * 0.8
        let result = goalHeight * CGFloat(percentage)
        return result.clamped(to: 0...maxHeight)
    }
    
}
