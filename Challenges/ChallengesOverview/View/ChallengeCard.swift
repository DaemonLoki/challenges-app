//
//  ChallengeCard.swift
//  Challenges
//
//  Created by Stefan Blos on 05.12.20.
//

import SwiftUI

struct ChallengeCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var challenge: Challenge
    
    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: colorScheme == .dark ? .systemThinMaterialDark : .systemThinMaterialLight, vibrancyStyle: .separator) {
                EmptyView()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(challenge.unwrappedName)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("TODAY - \(Int(challenge.dailyRepetitions(for: Date()))) / \(Int(challenge.regularGoal))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding()
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct ChallengeCard_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeCard(challenge: .preview)
            .padding()
            .previewLayout(.fixed(width: 300.0, height: 140.0))
    }
}
