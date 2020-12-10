//
//  Challenge+CoreDataProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 18.11.20.
//
//

import Foundation
import CoreData
import CoreGraphics


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var end: Date?
    @NSManaged public var frequency: String?
    @NSManaged public var goal: Double
    @NSManaged public var id: UUID
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var regularGoal: Double
    @NSManaged public var sendReminders: Bool
    @NSManaged public var start: Date?
    @NSManaged public var actions: NSSet?
    
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

// MARK: Generated accessors for actions
extension Challenge {

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: Action)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: Action)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSSet)

}

extension Challenge : Identifiable {

}

extension Challenge {
    static var preview: Challenge {
        let challenge = Challenge()
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

extension Challenge {
    
    func dailyRepetitions(for date: Date) -> Double {
        return actionsArray.filter { (action: Action) in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            return formatter.string(from: action.unwrappedDate) == formatter.string(from: date)
        }.reduce(0.0) { (previousResult, action) -> Double in
            previousResult + action.count
        }
    }
    
    var totalCount: Double {
        return actionsArray
            .map { $0.count }
            .reduce(0.0, { accumulated, nextValue in
                accumulated + nextValue
            })
    }
    
    func heightOfBar(for date: Date, with maxHeight: CGFloat) -> CGFloat {
        let percentage = dailyRepetitions(for: date) / regularGoal
        let goalHeight = maxHeight * 0.8
        let result = goalHeight * CGFloat(percentage)
        return result.clamped(to: 0...maxHeight)
    }
    
}
