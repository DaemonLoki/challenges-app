//
//  ChallengeView.swift
//  Challenges
//
//  Created by Stefan Blos on 04.11.20.
//

import SwiftUI

struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Namespace var namespace
    
    @State private var createActionExpanded = false
    @State private var currentDate = Date()
    
    @ObservedObject var challenge: Challenge
    
    var body: some View {
        ZStack {
            VStack {
                DailyCountCard(count: challenge.dailyRepetitions(for: currentDate), goal: challenge.regularGoal)
                    .padding()
                
                Spacer()
                
                TotalCountCard(totalCount: challenge.totalCount, goal: challenge.goal)
                    .padding()
                
            }
            .navigationTitle(challenge.unwrappedName)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    CreateActionContainer(challenge: challenge, expanded: $createActionExpanded) {
                        withAnimation(.spring()) {
                            createActionExpanded.toggle()
                        }
                    }
                    .matchedGeometryEffect(id: "createAction", in: namespace, isSource: !createActionExpanded)
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            createActionExpanded.toggle()
                        }
                    }
                    
                }
                .padding()
            }
            
            if createActionExpanded {
                VStack {
                    Spacer()
                    
                    CreateActionContainer(challenge: challenge, expanded: $createActionExpanded) {
                        withAnimation(.spring()) {
                            createActionExpanded.toggle()
                        }
                    }
                    .matchedGeometryEffect(id: "createAction", in: namespace)
                    .frame(height: 550)
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                }
                .transition(.opacity)
            }
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge.preview)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
