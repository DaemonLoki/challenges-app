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
    
    @ObservedObject var viewModel: ChallengesViewModel
    
    // Basic properties
    @State private var name: String = ""
    @State private var goal: String = ""
    
    // Additional properties
    @State private var includeEndDate: Bool = false
    @State private var includeDailyGoal: Bool = false
    
    @State private var endDate = Date()
    @State private var dailyGoal: String = ""
    
    @State private var selectedRegularGoal = 0
    
    var infoMissing: Bool {
        name.isEmpty || goal.isEmpty
    }
    
    var regularGoalOptions = ["daily", "weekly", "monthly", "yearly"]
    
    
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
                
                Section(header: Text("Regular goal")) {
                    Toggle(isOn: $includeDailyGoal.animation(.easeInOut), label: {
                        Text("Include regular goal")
                    })
                    
                    if includeDailyGoal {
                        Picker(selection: $selectedRegularGoal, label: Text("Regular goal"), content: {
                            ForEach(0 ..< regularGoalOptions.count) {
                                Text(self.regularGoalOptions[$0])
                            }
                        })
                        .pickerStyle(SegmentedPickerStyle())
                        
                        TextField("Add \(regularGoalOptions[selectedRegularGoal]) goal", text: $dailyGoal)
                            .keyboardType(.decimalPad)
                    }
                }
                
                Section {
                    Button(action: {
                        do {
                            try viewModel.tryCreateChallenge(named: name, with: Double(goal) ?? 0, regularGoal: includeDailyGoal ? Double(dailyGoal) : nil, endDate: includeEndDate ? endDate : nil, frequency: regularGoalOptions[selectedRegularGoal])
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
}

struct CreateChallengeForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateChallengeForm(viewModel: ChallengesViewModel(managedObjectContext: PersistenceController.preview.container.viewContext))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
