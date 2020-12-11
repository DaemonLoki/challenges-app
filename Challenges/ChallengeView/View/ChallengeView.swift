//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var defaultCount: Double? = nil
    
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
                    CreateActionContainer(viewModel: viewModel, createActionExpanded: $createActionExpanded)
                    
                    Spacer()
                    
                    if !createActionExpanded && defaultCount != nil {
                        Button {
                            // TODO
                        } label: {
                            QuickAddButton(text: "+\(defaultCount ?? 10)")
                        }
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                        )
                        .frame(width: 60, height: 60)
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            loadDefaultCountValue()
        }
    }
    
    func loadDefaultCountValue() {
        let savedValueForDefaultCount = UserDefaults.standard.double(forKey: viewModel.challenge.defaultActionCountStorageKey)
        if savedValueForDefaultCount > 0 {
            defaultCount = savedValueForDefaultCount
        }
    }
}
