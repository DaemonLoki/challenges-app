//
//  Challenge+FetchRequests.swift
//  Challenges
//
//  Created by Stefan Blos on 10.12.20.
//

import CoreData

extension Challenge {
    
    /* This request is necessary for the ChallengeViewModel.
     It is used to capture all available challenges from the database. */
    static var allChallengesRequest: NSFetchRequest<Challenge> {
        let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Challenge.start, ascending: true)]
        
        return request
    }
    
    /* This request is necessary for the ChallengeDetailViewModel.
     It is used to query a single challenge from the database. */
    static func challengeDetailRequest(for id: UUID) -> NSFetchRequest<Challenge> {
        let request: NSFetchRequest<Challenge> = Challenge.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Challenge.start, ascending: true)]
        
        return request
    }
}
