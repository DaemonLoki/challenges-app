//
//  Date+StringFormat.swift
//  Challenges
//
//  Created by Stefan Blos on 27.03.21.
//

import Foundation

extension Date {
    
    var toDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
}
