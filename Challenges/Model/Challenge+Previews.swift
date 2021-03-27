//
//  Challenge+Previews.swift
//  Challenges
//
//  Created by Stefan Blos on 12.12.20.
//

import Foundation

extension Challenge {
    static var preview: Challenge {
        let challenge = Challenge(context: PersistenceController.preview.container.viewContext)
        challenge.id = UUID()
        challenge.start = Date()
        challenge.name = "Challenge Preview"
        challenge.frequency = "daily"
        challenge.goal = 3000
        challenge.regularGoal = 100
        challenge.sendReminders = false
        challenge.isActive = true
        return challenge
    }
}
