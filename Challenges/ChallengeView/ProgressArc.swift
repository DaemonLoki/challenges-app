//
//  ProgressArc.swift
//  Challenges
//
//  Created by Stefan Blos on 09.12.20.
//

import SwiftUI

struct ProgressArc: View {
    
    var currentValue: Double
    var goalValue: Double?
    
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(currentValue * 360 / (goalValue ?? 1.0)))
            .stroke(LinearGradient.logoGradient, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .animation(.spring())
    }
}

struct ProgressArc_Previews: PreviewProvider {
    static var previews: some View {
        ProgressArc(currentValue: 40, goalValue: 100)
    }
}
