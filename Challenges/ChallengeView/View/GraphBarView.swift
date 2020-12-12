//
//  GraphBarView.swift
//  Challenges
//
//  Created by Stefan Blos on 22.11.20.
//

import SwiftUI

struct GraphBarView: View {
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    
    var index: Int
    
    @State private var barHeight: CGFloat = 0
    @State private var isBarHeightSet = false
    
    static let animationDelay = 0.09
    
    var body: some View {
        Color.white
            .frame(height: barHeight)
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .opacity(0.7)
            .onReceive(viewModel.$valuesOfLastWeek, perform: { values in
                withAnimation(Animation.spring().delay(isBarHeightSet ? 0 : Double(index) * GraphBarView.animationDelay)) {
                    isBarHeightSet = true
                    barHeight = values[index]
                }
            })
    }
    
}

struct GraphBarView_Previews: PreviewProvider {
    static var previews: some View {
        GraphBarView(viewModel: ChallengeDetailViewModel(id: UUID(), managedObjectContext: PersistenceController.preview.container.viewContext), index: 4)
    }
}
