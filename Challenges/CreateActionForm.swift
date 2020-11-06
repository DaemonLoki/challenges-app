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
    @State private var happenedInPast = false
    @State private var actionDate = Date()
    
    var challenge: Challenge
    
    var infoMissing: Bool {
        Double(count) == nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Count")) {
                    TextField("Count", text: $count)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Time")) {
                    Toggle(isOn: $happenedInPast.animation(.easeInOut), label: {
                        Text("Happened in the past")
                    })
                    
                    if happenedInPast {
                        DatePicker(selection: $actionDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute]) {
                            Text("When did you do that?")
                        }
                    }
                }
                
                Button(action: {
                    let action = Action(context: viewContext)
                    action.challenge = challenge
                    action.count = Double(count) ?? 0.0
                    action.date = happenedInPast ? actionDate : Date()
                    
                    try? viewContext.save()
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Create")
                }).disabled(infoMissing)
            }
            .navigationBarTitle("Add")
        }
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
