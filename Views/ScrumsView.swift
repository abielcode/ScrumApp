//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 19/10/22.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    @State private var newScrumData = DailyScrum.Data()
    @Environment(\.scenePhase) private var  scenePhase
    let saveAction: ()->Void
    
    private var allowAddingScrum: Bool {
        (newScrumData.attendees.isEmpty || newScrumData.title.isEmpty)
    }
    
    var body: some View {
        List($scrums) { $item in
            NavigationLink(destination: DetailView(scrum: $item)) {
                CardView(scrum: item)
            }
            .listRowBackground(item.theme.mainColor)
        }
        .navigationTitle("Daily scrum")
        .toolbar {
            Button(action: {
                isPresentingNewScrumView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New scrum")
        }
            // add new
        .sheet(isPresented: $isPresentingNewScrumView) {
            NavigationView {
                DetailEditView(data: $newScrumData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewScrumView = false
                                newScrumData = DailyScrum.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newScrum = DailyScrum(data: newScrumData)
                                scrums.append(newScrum)
                                isPresentingNewScrumView = false
                            }.disabled(allowAddingScrum)
                        }
                    }
            }
        }
        
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
        }
    }
}
