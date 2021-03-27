//
//  Action+Previews.swift
//  Challenges
//
//  Created by Stefan Blos on 05.03.21.
//

import Foundation

extension Action {
    static var preview: Action {
        let action = Action(context: PersistenceController.preview.container.viewContext)
        action.date = Date.from(day: 22, month: 10, year: 2020)
        action.count = 20
        action.challenge = Challenge.preview
        return action
    }
    
    static func createForPreview(on date: Date = Date.from(day: 22, month: 10, year: 2020)!, with count: Double = 20) -> Action {
        let action = Action(context: PersistenceController.preview.container.viewContext)
        action.date = date
        action.count = count
        action.challenge = Challenge.preview
        return action
    }
}
