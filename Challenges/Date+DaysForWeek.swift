//
//  Date+DaysForWeek.swift
//  Challenges
//
//  Created by Stefan Blos on 22.11.20.
//

import Foundation

extension Date {
    
    var daysForWeekBefore: [Date] {
        let cal = Calendar.current
        let startOfDayDate = cal.startOfDay(for: self)
        var daysOfWeek = [Date]()
        
        let numberOfDays = 7
        
        for i in 0..<numberOfDays {
            guard let previousDay = cal.date(byAdding: .day, value: -((numberOfDays-1) - i), to: startOfDayDate) else { continue }
            daysOfWeek.append(previousDay)
        }
        
        return daysOfWeek
    }
    
    var getWeekday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return dateFormatter.string(from: self)
    }
    
}
