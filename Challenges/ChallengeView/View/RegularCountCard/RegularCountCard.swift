//
//  DailyCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI
import CoreData

struct RegularCountCard: View {
    
    @Environment(\.colorScheme) var colorScheme
        
    var regularCount: Double
    var regularGoal: Double
    var frequency: ChallengeFrequency
    var circlePercentage: Double
    var goalReached: Bool
    
    @Binding var circleDegree: Double
        
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight, vibrancyStyle: .separator) {
                EmptyView()
            }
            
            if goalReached {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .stroke(LinearGradient.logoGradient, lineWidth: 8)
            }
            
            VStack {
                Text(frequency.rawValue.uppercased())
                    .font(.footnote)
                Text(regularCount.formatTwoDigitsMax())
                    .font(.largeTitle)
                
                Text(regularGoal.formatTwoDigitsMax())
            }
            
            if !goalReached {
                ProgressArc(currentValue: circleDegree, goalValue: regularGoal)
                    .frame(width: 120, height: 120)
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(radius: goalReached ? 10 : 2)
    }
}

struct RegularCountCard_Previews: PreviewProvider {
    static var previews: some View {
        RegularCountCard(regularCount: 20, regularGoal: 100, frequency: .weekly, circlePercentage: 20/100, goalReached: false, circleDegree: .constant(200))
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Double
    
    var insetAmount: CGFloat = 0
    
    var animatableData: Double {
        get { return endAngle }
        set { endAngle = newValue }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = .degrees(endAngle) - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: false)
        
        return path
    }
}
