//
//  DailyCountCard.swift
//  Challenges
//
//  Created by Stefan Blos on 20.11.20.
//

import SwiftUI

struct DailyCountCard: View {

    @Environment(\.colorScheme) var colorScheme
    
    var count: Double
    var goal: Double?
    
    var circlePercentage: Double {
        guard let unwrappedGoal = goal else { return 0.0 }
        return count * 360 / unwrappedGoal
    }
    
    var goalReached: Bool {
        guard let unwrappedGoal = goal else { return false }
        return count >= unwrappedGoal
    }
    
    var shadowAmount: Double {
        goalReached ? 20 : 0
    }
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight, vibrancyStyle: .separator) {
                EmptyView()
            }
            
            VStack {
                Text("TOTAL")
                    .font(.footnote)
                Text(count.formatTwoDigitsMax())
                    .font(.largeTitle)
                
                if let unwrappedGoal = goal {
                    Text(unwrappedGoal.formatTwoDigitsMax())
                }
            }
            
            if !goalReached {
                Arc(startAngle: .degrees(0), endAngle: .degrees(circlePercentage))
                    .stroke(LinearGradient.logoGradient, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .animation(.spring())
                    .frame(width: 120, height: 120)
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(radius: goalReached ? 20 : 2)
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
