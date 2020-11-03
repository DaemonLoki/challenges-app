//
//  Action+CoreDataProperties.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//
//

import Foundation
import CoreData


extension Action {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Action> {
        return NSFetchRequest<Action>(entityName: "Action")
    }

    @NSManaged public var count: Double
    @NSManaged public var date: Date?
    @NSManaged public var challenge: Challenge?

}

extension Action : Identifiable {

}
