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
            
            HStack {
                Spacer()
                
                Button(action: {
                    let action = Action(context: viewContext)
                    action.count = 20
                    action.date = Date()
                    action.challenge = challenge
                    
                    try? viewContext.save()
                }, label: {
                    Image(systemName: "plus")
                    Text("Add 20 Pushups")
                })
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
            }
            .padding()
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
    }
}
