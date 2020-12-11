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
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    @State private var circleDegree: Double = 0
    
    var count: Double {
        viewModel.challenge.dailyRepetitions(for: Date())
    }
    
    var circlePercentage: Double {
        return count * 360 / viewModel.challenge.regularGoal
    }
    
    var goalReached: Bool {
        return count >= viewModel.challenge.regularGoal
    }
    
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
                Text("DAILY")
                    .font(.footnote)
                Text(count.formatTwoDigitsMax())
                    .font(.largeTitle)
                
                Text(viewModel.challenge.regularGoal.formatTwoDigitsMax())
            }
            
            if !goalReached {
                ProgressArc(currentValue: circleDegree, goalValue: viewModel.challenge.regularGoal)
                    .frame(width: 120, height: 120)
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        .shadow(radius: goalReached ? 10 : 2)
        .onReceive(viewModel.$dailyCount, perform: { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(circleDegree == 0 ? 300 : 0)) {
                withAnimation(Animation.spring()) {
                    circleDegree = circlePercentage
                }
            }
        })
    }
}

struct DailyCountCard_Previews: PreviewProvider {
    static var previews: some View {
        DailyCountCard(viewModel: ChallengeDetailViewModel(id: UUID(), managedObjectContext: PersistenceController.preview.container.viewContext))
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
