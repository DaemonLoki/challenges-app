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
    
    @ObservedObject var viewModel: ChallengesViewModel
    
    @State private var showCreateChallengeSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    
                    ForEach(viewModel.challenges) { (challenge: Challenge) in
                            NavigationLink(
                                destination: ChallengeView(viewModel: ChallengeDetailViewModel(id: challenge.id, managedObjectContext: managedObjectContext))) {
                                ChallengeCard(challenge: challenge)
                            }

                        .padding(.horizontal)
                    }
                    .onDelete(perform: viewModel.removeChallenges)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("WillDo")
            .navigationBarItems(trailing: HStack {
                Button(action: {
                    showCreateChallengeSheet = true
                }, label: {
                    Text("New")
                })
            })
            .sheet(isPresented: $showCreateChallengeSheet, content: {
                CreateChallengeForm(viewModel: viewModel)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ChallengesViewModel(managedObjectContext: PersistenceController.preview.container.viewContext)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
