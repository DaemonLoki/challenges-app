//
//  GraphBarView.swift
//  Challenges
//
//  Created by Stefan Blos on 22.11.20.
//

import SwiftUI

struct GraphBarView: View {
    
    @ObservedObject var challenge: Challenge
    var date: Date
    var maxHeight: CGFloat
    var goalHeightFraction: CGFloat
    var delay: Double
    
    @State private var barHeight: CGFloat = 0
    
    var body: some View {
        Color.white
            .frame(height: barHeight)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .opacity(0.7)
            .onAppear {
                withAnimation(Animation.spring().delay(delay)) {
                    self.barHeight = calculateHeightOfBar(for: date)
                }
            }
    }
    
    func calculateHeightOfBar(for date: Date) -> CGFloat {
        let dailyRepetitions = challenge.dailyRepetitions(for: date)
        let regularGoal = challenge.regularGoal
        let percentage = dailyRepetitions / regularGoal
        let goalHeight = maxHeight * goalHeightFraction
        let result = goalHeight * CGFloat(percentage)
        return result.clamped(to: 0...maxHeight)
    }
    
}

struct GraphBarView_Previews: PreviewProvider {
    static var previews: some View {
        GraphBarView(challenge: .preview, date: Date(), maxHeight: 120, goalHeightFraction: 0.8, delay: 0.4)
    }
}
