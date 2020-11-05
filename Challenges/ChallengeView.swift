//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var challenge: Challenge
    
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
            Text("Current value")
            Text("\(Int(totalCount))")
                .font(.largeTitle)
            Spacer()
            
            Button(action: {
                let action = Action(context: viewContext)
                action.count = 20
                action.date = Date()
                action.challenge = challenge
                
                try? viewContext.save()
            }, label: {
                Text("Add 20 Pushups")
            })
        }
        .navigationTitle(challenge.name)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge.preview)
    }
}
