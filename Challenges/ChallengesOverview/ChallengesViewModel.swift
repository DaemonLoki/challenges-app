//
//  ChallengesViewModel.swift
//  Challenges
//
//  Created by Stefan Blos on 09.12.20.
//

import Foundation
import CoreData

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
}

extension ChallengesViewModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let challengeItems = controller.fetchedObjects as? [Challenge] else { return }
        
        challenges = challengeItems
    }
}
