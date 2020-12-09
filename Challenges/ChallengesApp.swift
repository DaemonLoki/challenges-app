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
    
    @StateObject var challengesViewModel: ChallengesViewModel
    
    init() {
        let viewModel = ChallengesViewModel(managedObjectContext: persistenceController.container.viewContext)
        self._challengesViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: challengesViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
