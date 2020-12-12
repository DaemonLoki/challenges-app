//
//  Challenge+AdditionalProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 12.12.20.
//

import Foundation

extension Challenge: Identifiable {
    var unwrappedName: String {
        name ?? "Unknown"
    }
    
    var actionsArray: [Action] {
        let set = actions as? Set<Action> ?? []
        return set.sorted {
            $0.unwrappedDate < $1.unwrappedDate
        }
    }
}
