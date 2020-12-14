//
//  ChallengesViewModel.swift
//  Challenges
//
//  Created by Stefan Blos on 09.12.20.
//

import Foundation
import CoreData
import SwiftUI

class ChallengesViewModel: NSObject, ObservableObject {
    @Published var challenges: [Challenge] = []
    
    private let challengesController: NSFetchedResultsController<Challenge>
    private let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        challengesController = NSFetchedResultsController(fetchRequest: Challenge.allChallengesRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.managedObjectContext = managedObjectContext
        
        super.init()
        
        challengesController.delegate = self
        
        do {
            try challengesController.performFetch()
            challenges = challengesController.fetchedObjects ?? []
        } catch {
            print("Failed to fetch items!")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func removeChallenges(at offsets: IndexSet) {
        for index in offsets {
            let challenge = challenges[index]
            managedObjectContext.delete(challenge)
        }
        
        if (managedObjectContext.hasChanges) {
            do {
                try managedObjectContext.save()
            } catch  {
                print("Error occurred: \(error)")
            }
        }
    }
    
    func tryCreateChallenge(named name: String, with goal: Double, regularGoal: Double?, endDate: Date?) throws {
        let challenge = Challenge(context: managedObjectContext)
        
        // set basic data
        challenge.id = UUID()
        challenge.name = name
        challenge.start = Date()
        challenge.goal = goal
        
        // set additional data
        if let endDate = endDate {
            challenge.end = endDate
        }
        
        if let regularGoal = regularGoal {
            challenge.regularGoal = regularGoal
        }
        
        // set data that is not supported yet
        challenge.frequency = "daily"
        challenge.isActive = true
        challenge.sendReminders = false
        
        try managedObjectContext.save()
    }
    
    @objc func appEnteredForeground() {
        do {
            try challengesController.performFetch()
            challenges = challengesController.fetchedObjects ?? []
        } catch {
            print("Failed to fetch items on move to foreground.")
        }
    }
}

extension ChallengesViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let challengeItems = controller.fetchedObjects as? [Challenge] else { return }
        
        challenges = challengeItems
    }
}
