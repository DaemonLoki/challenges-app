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
    
    @State private var barHeight: CGFloat = 0
    
    var body: some View {
        Color.white
            .frame(height: challenge.heightOfBar(for: date, with: maxHeight))
            .animation(.spring())
            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            .opacity(0.7)
            .animation(nil)
    }
    
}

struct GraphBarView_Previews: PreviewProvider {
    static var previews: some View {
        GraphBarView(challenge: .preview, date: Date(), maxHeight: 120)
    }
}
