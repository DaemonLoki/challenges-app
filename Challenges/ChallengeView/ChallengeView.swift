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
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    DailyCountCard(count: viewModel.challenge.dailyRepetitions(for: currentDate), goal: viewModel.challenge.regularGoal)
                    .padding()
                
                    TotalCountCard(totalCount: viewModel.challenge.totalCount, goal: viewModel.challenge.goal)
                    .padding()
                }
                
                WeeklyGraphCard(challenge: viewModel.challenge, currentDate: currentDate)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle(viewModel.challengeName)
            
            CreateActionContainer(challenge: viewModel.challenge)
        }
    }
}
