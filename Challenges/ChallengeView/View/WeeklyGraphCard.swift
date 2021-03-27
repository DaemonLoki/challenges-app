//
//  WeeklyGraphCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct WeeklyGraphCard: View {
    
    // Outside elements
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    var currentDate: Date
    
    let maxHeight: CGFloat = 120
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(currentDate.daysForWeekBefore.indices, id: \.self) { index in
                VStack {
                    VStack {
                        Spacer()
                        
                        GraphBarView(viewModel: viewModel, index: index)
                    }
                    .frame(height: maxHeight)
                    
                    Text("\(Challenge.dailyRepetitions(for: currentDate.daysForWeekBefore[index], in: viewModel.challenge.actionsArray).formatTwoDigitsMax())")
                    
                    Text(currentDate.daysForWeekBefore[index].getWeekday)
                        .font(.caption)
                }
                .foregroundColor(.white)
            }
        }
        .padding()
        .background(LinearGradient.logoGradient)
    }
}

struct WeeklyGraphCard_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyGraphCard(viewModel: ChallengeDetailViewModel(id: UUID(), managedObjectContext: PersistenceController.preview.container.viewContext), currentDate: Date())
    }
}
