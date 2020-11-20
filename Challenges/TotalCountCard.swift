//
//  TotalCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct TotalCountCard: View {
    
    var totalCount: Double
    var goal: Double
    
    var body: some View {
        VStack {
            Text("TOTAL")
                .font(.footnote)
            Text(totalCount.formatTwoDigitsMax())
                .font(.largeTitle)
            Text(goal.formatTwoDigitsMax())
        }
    }
}

struct TotalCountCard_Previews: PreviewProvider {
    static var previews: some View {
        TotalCountCard(totalCount: 200, goal: 1000)
    }
}
