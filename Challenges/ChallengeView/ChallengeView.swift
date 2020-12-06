//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var currentDate = Date()
    
    @ObservedObject var challenge: Challenge
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                DailyCountCard(count: challenge.dailyRepetitions(for: currentDate), goal: challenge.regularGoal)
                    .padding()
                
                TotalCountCard(totalCount: challenge.totalCount, goal: challenge.goal)
                    .padding()
                }
                
                WeeklyGraphCard(challenge: challenge, currentDate: currentDate)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle(challenge.unwrappedName)
            
            CreateActionContainer(challenge: challenge)
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge.preview)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
