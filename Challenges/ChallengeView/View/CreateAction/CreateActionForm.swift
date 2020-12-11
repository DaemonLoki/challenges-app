//
//  CreateActionForm.swift
//  Challenges
//
//  Created by Stefan Blos on 05.11.20.
//

import SwiftUI

struct CreateActionForm: View {
    
    @ObservedObject var viewModel: ChallengeDetailViewModel
    @Binding var defaultCount: Double?
    
    @State private var count = ""
    @State private var happenedInPast = false
    @State private var actionDate = Date()
    
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
                    do {
                        try viewModel.addAction(with: Double(count) ?? 0.0, at: happenedInPast ? actionDate : Date())
                        defaultCount = Double(count)
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
            CreateActionForm(viewModel: ChallengeDetailViewModel(id: UUID(), managedObjectContext: PersistenceController.preview.container.viewContext), defaultCount: .constant(20.0)) {}
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
