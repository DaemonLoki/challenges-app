//
//  Double+Formatter.swift
//  Challenges
//
//  Created by Stefan Blos on 19.11.20.
//

import Foundation

extension Double {
    
    func formatTwoDigitsMax() -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: self)
        return formatter.string(from: number)!
    }
    
}
