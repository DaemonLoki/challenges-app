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
    @State private var createActionExpanded = false
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    DailyCountCard(count: viewModel.challenge.dailyRepetitions(for: currentDate), goal: viewModel.challenge.regularGoal)
                        .padding()
                    
                    TotalCountCard(totalCount: viewModel.challengeTotalCount, goal: viewModel.challengeGoal)
                        .padding()
                }
                
                WeeklyGraphCard(challenge: viewModel.challenge, currentDate: currentDate)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle(viewModel.challengeName)
            
            VStack {
                Spacer()
                
                HStack {
                    CreateActionContainer(challenge: viewModel.challenge, createActionExpanded: $createActionExpanded)
                    
                    Spacer()
                    
                    if !createActionExpanded {
                        Button {
                            // TODO
                        } label: {
                            Image(systemName: "plus")
                                .background(Color.blue)
                        }
                    }
                }
            }
        }
    }
}
