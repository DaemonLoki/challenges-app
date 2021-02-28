//
//  RegularCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 26.02.21.
//

import SwiftUI

struct RegularCountWrapper: View {
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    var count: Double {
        viewModel.challenge.dailyRepetitions(for: Date())
    }
    
    var circlePercentage: Double {
        return count * 360 / viewModel.challenge.regularGoal
    }
    
    var goalReached: Bool {
        return count >= viewModel.challenge.regularGoal
    }
    
    @State private var circleDegree: Double = 0
    
    var body: some View {
        RegularCountCard(
            regularCount: count,
            regularGoal: viewModel.challenge.regularGoal,
            frequency: viewModel.challenge.frequencyType,
            circlePercentage: circlePercentage,
            goalReached: goalReached,
            circleDegree: $circleDegree
        )
            .onReceive(viewModel.$dailyCount, perform: { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(circleDegree == 0 ? 300 : 0)) {
                    withAnimation(Animation.spring()) {
                        circleDegree = circlePercentage
                    }
                }
            })
        
    }
}

struct RegularCountWrapper_Previews: PreviewProvider {
    static var previews: some View {
        RegularCountWrapper(viewModel: ChallengeDetailViewModel(id: UUID(), managedObjectContext: PersistenceController.preview.container.viewContext))
    }
}
