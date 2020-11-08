//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showCreateActionSheet = false
    
    @ObservedObject var challenge: Challenge
    
    var totalCount: Double {
        return challenge.actions?.array
            .compactMap { $0 as? Action }
            .map { $0.count }
            .reduce(0.0, { accumulated, nextValue in
                accumulated + nextValue
            })
            ?? 0.0
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Current value")
            Text(String(format: "%.0f", totalCount))
                .font(.largeTitle)
            Spacer()
        }
        .navigationTitle(challenge.name)
        .navigationBarItems(trailing: Button(action: {
            showCreateActionSheet = true
        }, label: {
            Image(systemName: "plus.circle")
        }))
        .sheet(isPresented: $showCreateActionSheet, content: {
            CreateActionForm(challenge: challenge)
        })
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge.preview)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
