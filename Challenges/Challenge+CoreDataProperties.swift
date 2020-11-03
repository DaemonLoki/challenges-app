//
//  Challenge+CoreDataProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//
//

import Foundation
import CoreData


extension Challenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Challenge> {
        return NSFetchRequest<Challenge>(entityName: "Challenge")
    }

    @NSManaged public var name: String
    @NSManaged public var id: UUID
    @NSManaged public var start: Date
    @NSManaged public var end: Date?
    @NSManaged public var goal: Double
    @NSManaged public var frequency: String
    @NSManaged public var sendReminders: Bool
    @NSManaged public var regularGoal: Double
    @NSManaged public var isActive: Bool
    @NSManaged public var actions: NSOrderedSet?

}

// MARK: Generated accessors for actions
extension Challenge {

    @objc(insertObject:inActionsAtIndex:)
    @NSManaged public func insertIntoActions(_ value: Action, at idx: Int)

    @objc(removeObjectFromActionsAtIndex:)
    @NSManaged public func removeFromActions(at idx: Int)

    @objc(insertActions:atIndexes:)
    @NSManaged public func insertIntoActions(_ values: [Action], at indexes: NSIndexSet)

    @objc(removeActionsAtIndexes:)
    @NSManaged public func removeFromActions(at indexes: NSIndexSet)

    @objc(replaceObjectInActionsAtIndex:withObject:)
    @NSManaged public func replaceActions(at idx: Int, with value: Action)

    @objc(replaceActionsAtIndexes:withActions:)
    @NSManaged public func replaceActions(at indexes: NSIndexSet, with values: [Action])

    @objc(addActionsObject:)
    @NSManaged public func addToActions(_ value: Action)

    @objc(removeActionsObject:)
    @NSManaged public func removeFromActions(_ value: Action)

    @objc(addActions:)
    @NSManaged public func addToActions(_ values: NSOrderedSet)

    @objc(removeActions:)
    @NSManaged public func removeFromActions(_ values: NSOrderedSet)

}

extension Challenge : Identifiable {

}
