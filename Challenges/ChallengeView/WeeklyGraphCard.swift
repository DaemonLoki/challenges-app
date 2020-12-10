//
//  WeeklyGraphCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct WeeklyGraphCard: View {
    
    // Outside elements
    @ObservedObject var challenge: Challenge
    var currentDate: Date
    
    let maxHeight: CGFloat = 120
    let goalHeightFraction: CGFloat = 0.8
    
    let baseDelay = 0.1
    let delaySteps = 0.05
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(currentDate.daysForWeekBefore.indices, id: \.self) { index in
                VStack {
                    VStack {
                        Spacer()
                        
                        GraphBarView(challenge: challenge, date: currentDate.daysForWeekBefore[index], maxHeight: maxHeight)
                    }
                    .frame(height: maxHeight)
                    
                    Text("\(challenge.dailyRepetitions(for: currentDate.daysForWeekBefore[index]).formatTwoDigitsMax())")
                    
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
        WeeklyGraphCard(challenge: .preview, currentDate: Date())
    }
}
