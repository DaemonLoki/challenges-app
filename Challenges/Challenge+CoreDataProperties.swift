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
