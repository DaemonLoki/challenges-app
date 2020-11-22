//
//  WeeklyGraphCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct WeeklyGraphCard: View {
    
    // Outside elements
    var challenge: Challenge
    var currentDate: Date
    
    let maxHeight: CGFloat = 120
    let goalHeightFraction: CGFloat = 0.8
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(currentDate.daysForWeekBefore, id: \.self) { date in
                VStack {
                    VStack {
                        Spacer()
                        
                        Color.white
                            .frame(height: calculateHeightOfBar(for: date))
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .opacity(0.7)
                    }
                    .frame(height: maxHeight)
                    
                    Text("\(challenge.dailyRepetitions(for: date).formatTwoDigitsMax())")
                    
                    Text(date.getWeekday)
                        .font(.caption)
                }
                .foregroundColor(.white)
            }
        }
        .padding()
        .background(LinearGradient.logoGradient)
    }
    
    func calculateHeightOfBar(for date: Date) -> CGFloat {
        let dailyRepetitions = challenge.dailyRepetitions(for: date)
        let regularGoal = challenge.regularGoal
        let percentage = dailyRepetitions / regularGoal
        let goalHeight = maxHeight * goalHeightFraction
        let result = goalHeight * CGFloat(percentage)
        print("result: \(result), clamped: \(result.clamped(to: 0...maxHeight))")
        return result.clamped(to: 0...maxHeight)
    }
}

struct WeeklyGraphCard_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyGraphCard(challenge: .preview, currentDate: Date())
    }
}
