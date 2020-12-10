//
//  CreateActionContainer.swift
//  Challenges
//
//  Created by Stefan Blos on 11.11.20.
//

import SwiftUI

struct CreateActionContainer: View {
    
    @ObservedObject var challenge: Challenge
    @State private var createActionExpanded = false
    
    @Namespace var namespace
    
    @State private var currentScale: CGFloat = 0
    
    var body: some View {
        VStack {
            // Create Action Card
            if createActionExpanded {
                CreateActionForm(challenge: challenge) {
                    withAnimation {
                        createActionExpanded.toggle()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .matchedGeometryEffect(id: "createAction", in: namespace)
                .frame(height: 550)
                .gesture(
                    createActionExpanded ?
                    DragGesture().onChanged { value in
                        if value.translation.height > 100 {
                            withAnimation {
                                createActionExpanded = false
                            }
                        } else {
                            self.currentScale = abs(value.translation.height)
                        }
                    }
                    .onEnded { value in
                        if value.translation.height > 100 {
                            withAnimation {
                                createActionExpanded = false
                            }
                        } else {
                            currentScale = 0
                        }
                    }
                    : nil
                )
                .scaleEffect(1 - (currentScale / 1000))
                .animation(.spring())
                .transition(.opacity)
            }
            
            // Button
            if !createActionExpanded {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        withAnimation {
                            createActionExpanded = true
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding()
                            .background(LinearGradient.logoGradient)
                    }
                    .clipShape(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .matchedGeometryEffect(id: "createAction", in: namespace, isSource: !createActionExpanded)
                    .frame(width: 60, height: 60)
                    .padding()
                }
            }
        }
    }
}

struct CreateActionContainer_Previews: PreviewProvider {
    static var previews: some View {
        CreateActionContainer(challenge: .preview)
    }
}
