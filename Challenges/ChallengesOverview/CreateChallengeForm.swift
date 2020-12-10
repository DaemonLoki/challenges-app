//
//  CreateChallengeForm.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//

import SwiftUI

struct CreateChallengeForm: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment (\.presentationMode) var presentationMode
    
    // Basic properties
    @State private var name: String = ""
    @State private var goal: String = ""
    
    // Additional properties
    @State private var includeEndDate: Bool = false
    @State private var includeDailyGoal: Bool = false
    
    @State private var endDate = Date()
    @State private var dailyGoal: String = ""
    
    var infoMissing: Bool {
        name.isEmpty || goal.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basics")) {
                    TextField("Name", text: $name)
                    
                    TextField("Goal", text: $goal)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("End date")) {
                    Toggle(isOn: $includeEndDate.animation(.easeInOut), label: {
                        Text("Include end date")
                    })
                    
                    if includeEndDate {
                        DatePicker(selection: $endDate, in: Date()..., displayedComponents: .date) {
                            Text("Select end date:")
                        }
                    }
                }
                
                Section(header: Text("Daily goal")) {
                    Toggle(isOn: $includeDailyGoal.animation(.easeInOut), label: {
                        Text("Include daily goal")
                    })
                    
                    if includeDailyGoal {
                        TextField("Add daily goal", text: $dailyGoal)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    Button(action: {
                        let challenge = tryCreateChallenge()
                        do {
                            try viewContext.save()
                            presentationMode.wrappedValue.dismiss()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }) {
                        Text("Create")
                    }.disabled(infoMissing)
                }
            }
            .navigationTitle("New Challenge")
        }
    }
    
    func tryCreateChallenge() -> Challenge {
        let challenge = Challenge(context: viewContext)
        
        // set basic data
        challenge.id = UUID()
        challenge.name = name
        challenge.start = Date()
        challenge.goal = Double(goal) ?? 0
        
        // set additional data
        if includeEndDate {
            challenge.end = endDate
        }
        
        if includeDailyGoal {
            challenge.regularGoal = Double(dailyGoal) ?? 0
        }
        
        // set data that is not supported yet
        challenge.frequency = "daily"
        challenge.isActive = true
        challenge.sendReminders = false
        
        return challenge
    }
}

struct CreateChallengeForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateChallengeForm()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
