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
                    RegularCountWrapper(viewModel: viewModel)
                        .padding()
                    
                    TotalCountCard(totalCount: viewModel.challengeTotalCount, goal: viewModel.challengeGoal)
                        .padding()
                }
                
                WeeklyGraphCard(viewModel: viewModel, currentDate: currentDate)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .padding()
                
                Spacer()
                
            }
            .navigationTitle(viewModel.challengeName)
            
            VStack {
                Spacer()
                
                HStack {
                    if defaultCount == nil {
                        Spacer()
                    }
                    
                    CreateActionContainer(viewModel: viewModel, defaultCount: $defaultCount, createActionExpanded: $createActionExpanded)
                    
                    if defaultCount != nil {
                        Spacer()
                        
                        if !createActionExpanded {
                            Button {
                                guard let defaultValue = defaultCount else { return }
                                do {
                                    try viewModel.addAction(with: defaultValue, at: Date())
                                } catch {
                                    print("Error occurred when trying to save default value of \(defaultValue) to challenge \(viewModel.challenge.unwrappedName)")
                                }
                            } label: {
                                QuickAddButton(count: defaultCount?.formatTwoDigitsMax() ?? "10")
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
