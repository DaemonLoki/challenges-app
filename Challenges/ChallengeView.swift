//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    var challenge: Challenge
    
    var body: some View {
        VStack {
            Text("Current value")
            Text("\(challenge.actions?.count ?? 0)")
                .font(.largeTitle)
            Spacer()
            
            Button(action: {
                // TODO action
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
