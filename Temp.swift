//
//  Temp.swift
//  Challenges
//
//  Created by Stefan Blos on 22.11.20.
//

import SwiftUI

struct Temp: View {
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<7) { tmp in
                VStack {
                    VStack {
                        Spacer()
                        
                        Color.green
                            .frame(height: CGFloat(30 * tmp))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                    .frame(height: 200)
                    Text("Tmp")
                    
                    Text("ADE")
                        .font(.caption)
                }
            }
        }
        .padding()
    }
}

struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        Temp()
    }
}
