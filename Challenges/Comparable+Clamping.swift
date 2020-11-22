//
//  Comparable+Clamping.swift
//  Challenges
//
//  Created by Stefan Blos on 22.11.20.
//

import Foundation

extension Comparable {
    
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
    
}
