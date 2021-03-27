//
//  ChallengeDetailViewModel.swift
//  Challenges
//
//  Created by Stefan Blos on 10.12.20.
//

import Foundation
import CoreData
import CoreGraphics
import SwiftUI

class ChallengeDetailViewModel: NSObject, ObservableObject {
    @Published var challenge: Challenge
    
    @Published var dailyCount: Double
    @Published var regularCount: Double
    @Published var valuesOfLastWeek: [CGFloat] = []
    
    var challengeName: String {
        challenge.unwrappedName
    }
    
    var challengeTotalCount: Double {
        challenge.totalCount
    }
    
    var challengeGoal: Double {
        challenge.goal
    }
    
    var challengeFrequency: String? {
        challenge.frequency
    }
    
    static let maxHeight: CGFloat = 120
    
    private let challengesController: NSFetchedResultsController<Challenge>
    private let managedObjectContext: NSManagedObjectContext
    
    init(id: UUID, managedObjectContext: NSManagedObjectContext) {
        challengesController = NSFetchedResultsController(fetchRequest: Challenge.challengeDetailRequest(for: id), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.managedObjectContext = managedObjectContext
        
        do {
            try challengesController.performFetch()
            guard let unwrappedChallenge = challengesController.fetchedObjects?.first else { fatalError("Couldn't find challenge with id \(id)") }
            challenge = unwrappedChallenge
            
            // set publishers
            dailyCount = Challenge.dailyRepetitions(for: Date(), in: unwrappedChallenge.actionsArray)
            switch unwrappedChallenge.frequencyType {
            case .daily:
                regularCount = Challenge.dailyRepetitions(for: Date(), in: unwrappedChallenge.actionsArray)
            case .weekly:
                regularCount = unwrappedChallenge.weeklyRepetitions(for: Date())
            case .monthly:
                regularCount = unwrappedChallenge.monthlyRepetitions(for: Date())
            case .yearly:
                regularCount = unwrappedChallenge.yearlyRepetitions(for: Date())
            }
        } catch {
            fatalError("Failed to fetch item for challenge with id \(id)")
        }
        
        super.init()
        challengesController.delegate = self
        
        valuesOfLastWeek = Date().daysForWeekBefore.map {
            challenge.heightOfBar(for: $0, with: ChallengeDetailViewModel.maxHeight)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(appEnteredForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func addAction(with count: Double, at date: Date) throws {
        let action = Action(context: managedObjectContext)
        action.count = count
        action.date = date
        
        challenge.addToActions(action)
        
        try managedObjectContext.save()
        
        UserDefaults.standard.set(count, forKey: challenge.defaultActionCountStorageKey)
        
        updatePublishers()
    }
    
    private func updatePublishers() {
        dailyCount = Challenge.dailyRepetitions(for: Date(), in: challenge.actionsArray)
        valuesOfLastWeek = Date().daysForWeekBefore.map {
            challenge.heightOfBar(for: $0, with: ChallengeDetailViewModel.maxHeight)
        }
    }
    
    @objc func appEnteredForeground() {
        do {
            try challengesController.performFetch()
            guard let unwrappedChallenge = challengesController.fetchedObjects?.first else { fatalError("Couldn't find challenge with id") }
            challenge = unwrappedChallenge
        } catch {
            print("Failed to fetch challenge item on move to foreground.")
        }
        
        updatePublishers()
    }
}

extension ChallengeDetailViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let challengeItem = controller.fetchedObjects?.first as? Challenge else { return }
        
        challenge = challengeItem
    }
}
