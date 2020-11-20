//
//  DailyCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct DailyCountCard: View {
    
    var count: Double
    var goal: Double?
    
    var body: some View {
        VStack {
            Text("TODAY")
            Text(count.formatTwoDigitsMax())
                .font(.largeTitle)
            
            if let unwrappedGoal = goal {
                Text(unwrappedGoal.formatTwoDigitsMax())
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gradientEnd)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
    }
}

struct DailyCountCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyCountCard(count: 20, goal: 100)
    }
}
