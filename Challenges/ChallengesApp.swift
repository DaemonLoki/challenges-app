//
//  ChallengesApp.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//

import SwiftUI

@main
struct ChallengesApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
