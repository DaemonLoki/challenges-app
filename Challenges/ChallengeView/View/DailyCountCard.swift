//
//  DailyCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI
import CoreData

struct DailyCountCard: View {

    @Environment(\.colorScheme) var colorScheme
    
    var count: Double
    var goal: Double?
    
    @State private var circleDegree: Double = 0
    
    var circlePercentage: Double {
        guard let unwrappedGoal = goal else { return 0.0 }
        return count * 360 / unwrappedGoal
    }
    
    var goalReached: Bool {
        guard let unwrappedGoal = goal else { return false }
        return count >= unwrappedGoal
    }
        
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight, vibrancyStyle: .separator) {
                EmptyView()
            }
            
            if goalReached {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(LinearGradient.logoGradient)
            }
            
            VStack {
                Text("DAILY")
                    .font(.footnote)
                Text(count.formatTwoDigitsMax())
                    .font(.largeTitle)
                
                if let unwrappedGoal = goal {
                    Text(unwrappedGoal.formatTwoDigitsMax())
                }
            }.foregroundColor(goalReached ? .white : .primary)
            
            if !goalReached {
                ProgressArc(currentValue: count, goalValue: goal ?? 1.0)
                    .frame(width: 120, height: 120)
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(radius: goalReached ? 10 : 2)
        .onAppear {
            circleDegree = circlePercentage
        }
    }
}

struct DailyCountCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyCountCard(count: 100, goal: 100)
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: false)
        
        return path
    }
}
