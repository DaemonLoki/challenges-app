//
//  ContentView.swift
//  Challenges
//
//  Created by Stefan Blos on 03.11.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Challenge.start, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Challenge>
    
    @State private var showCreateChallengeSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink(
                        destination: ChallengeView(challenge: item),
                        label: {
                            Text("\(item.name)")
                        }
                    )
                }
                .onDelete(perform: removeChallenges)
            }
            .navigationTitle("Challenges")
            .navigationBarItems(trailing: HStack {
                EditButton()
                
                Button(action: {
                    showCreateChallengeSheet = true
                }, label: {
                    Image(systemName: "plus.circle")
                })
            })
            .sheet(isPresented: $showCreateChallengeSheet, content: {
                CreateChallengeForm()
            })
        }
    }
    
    func removeChallenges(at offsets: IndexSet) {
        for index in offsets {
            let challenge = items[index]
            viewContext.delete(challenge)
        }
        
        try? viewContext.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
