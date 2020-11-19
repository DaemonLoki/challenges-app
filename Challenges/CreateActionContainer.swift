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
    
    @State private var currentScale: CGFloat = 0
    
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
        .gesture(
            DragGesture().onChanged { value in
                self.currentScale = abs(value.translation.height)
                print(abs(value.translation.height))
            }
            .onEnded { value in
                if value.translation.height > 100 {
                    toggle()
                } else {
                    currentScale = 0
                }
            })
        .scaleEffect(1 - (currentScale / 1000))
        .animation(.spring())
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
