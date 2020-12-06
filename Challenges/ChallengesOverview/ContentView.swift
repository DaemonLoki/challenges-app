//
//  ContentView.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Challenge.start, ascending: true)],
        animation: .default)
    private var challenges: FetchedResults<Challenge>
    
    @State private var showCreateChallengeSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    
                    ForEach(challenges) { (challenge: Challenge) in
                            NavigationLink(
                                destination: ChallengeView(challenge: challenge)) {
                                ChallengeCard(challenge: challenge)
                            }

                        .padding(.horizontal)
                    }
                    .onDelete(perform: removeChallenges)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Challenges")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    showCreateChallengeSheet = true
                }, label: {
                    Text("New")
                })
            })
            .sheet(isPresented: $showCreateChallengeSheet, content: {
                CreateChallengeForm()
            })
        }
    }
    
    func removeChallenges(at offsets: IndexSet) {
        for index in offsets {
            let challenge = challenges[index]
            managedObjectContext.delete(challenge)
        }
        
        if (managedObjectContext.hasChanges) {
            do {
                try managedObjectContext.save()
            } catch  {
                print("Error occurred: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
