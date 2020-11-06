//
//  CreateActionForm.swift
//  Challenges
//
//  Created by Stefan Blos on 05.11.20.
//

import SwiftUI

struct CreateActionForm: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    @State private var count = ""
    
    var challenge: Challenge
    
    var body: some View {
        Form {
            Section(header: Text("Count")) {
                TextField("Count", text: $count)
                    .keyboardType(.decimalPad)
            }
            
            Button(action: {
                let action = Action(context: viewContext)
                action.challenge = challenge
                action.count = Double(count) ?? 0.0
                action.date = Date()
                
                try? viewContext.save()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Create")
            })
        }
        .navigationTitle("Add")
    }
}

struct CreateActionForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateActionForm(challenge: Challenge.preview)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
