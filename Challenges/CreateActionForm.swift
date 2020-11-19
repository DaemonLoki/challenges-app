//
//  CreateActionForm.swift
//  Challenges
//
//  Created by Stefan Blos on 05.11.20.
//

import SwiftUI

struct CreateActionForm: View {
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    
    @State private var count = ""
    @State private var happenedInPast = false
    @State private var actionDate = Date()
    
    var challenge: Challenge
    var toggle: () -> Void
    
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
                    let action = Action(context: managedObjectContext)
//                    action.challenge = challenge
                    action.count = Double(count) ?? 0.0
                    action.date = happenedInPast ? actionDate : Date()
                    
                    challenge.addToActions(action)
                    
                    print("Challenge for Action is: \(action.challenge?.unwrappedName ?? "Unknown")")
                    
                    do {
                        try managedObjectContext.save()
                    } catch {
                        print("Error occurred: \(error)")
                    }
                    toggle()
                }, label: {
                    Text("Create")
                }).disabled(infoMissing)
            }
            .navigationBarTitle("Add")
            .navigationBarItems(trailing: Button(action: {
                toggle()
            }, label: {
                Image(systemName: "xmark")
            }))
        }
    }
}

struct CreateActionForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateActionForm(challenge: Challenge.preview) {}
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
