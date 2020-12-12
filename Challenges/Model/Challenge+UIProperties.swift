//
//  Challenge+UIProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 12.12.20.
//

import Foundation
import CoreGraphics

extension Challenge {
    
    func dailyRepetitions(for date: Date) -> Double {
        return actionsArray.filter { (action: Action) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            return formatter.string(from: action.unwrappedDate) == formatter.string(from: date)
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
        let percentage = dailyRepetitions(for: date) / (regularGoal == 0 ? 1 : regularGoal)
        let goalHeight = maxHeight * 0.8
        let result = goalHeight * CGFloat(percentage)
        return result.clamped(to: 0...maxHeight)
    }
    
}
