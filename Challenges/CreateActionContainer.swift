//
//  CreateActionContainer.swift
//  Challenges
//
//  Created by Stefan Blos on 11.11.20.
//

import SwiftUI

struct CreateActionContainer: View {
    
    var challenge: Challenge
    @Binding var expanded: Bool
    var toggle: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                
                if expanded {
                    CreateActionForm(challenge: challenge) {
                        toggle()
                    }
                } else {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            Spacer()
        }
        .background(expanded ? nil : LinearGradient.logoGradient)
        .clipShape(RoundedRectangle(cornerRadius: expanded ? 25.0 : 30.0, style: .continuous))
    }
}

struct CreateActionContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateActionContainer(challenge: .preview, expanded: .constant(false)) {}
            CreateActionContainer(challenge: .preview, expanded: .constant(true)) {}
        }
    }
}
