//
//  QuickAddButton.swift
//  Challenges
//
//  Created by Stefan Blos on 11.12.20.
//

import SwiftUI

struct QuickAddButton: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .bold()
            .foregroundColor(.white)
            .frame(width: 60, height: 60)
            .background(LinearGradient.logoGradient)
            .clipShape(Circle())
            
    }
}

struct QuickAddButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuickAddButton(text: "+1000")
                .previewLayout(.sizeThatFits)
            QuickAddButton(text: "+1000")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
            QuickAddButton(text: "+1000")
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .extraSmall)
                .previewLayout(.sizeThatFits)
            QuickAddButton(text: "+100")
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
                .previewLayout(.sizeThatFits)
        }
    }
}
