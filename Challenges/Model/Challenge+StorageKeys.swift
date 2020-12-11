//
//  Challenge+StorageKeys.swift
//  Challenges
//
//  Created by Stefan Blos on 11.12.20.
//

import Foundation

extension Challenge {
    
    var defaultActionCountStorageKey: String {
        return "\(id.uuidString)-default-action-count"
    }
    
}
