//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 20/10/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    @State private var data = DailyScrum.Data()
    @State private var isPresentingEditView = false

    var body: some View {
            List {
            //Meeting info
                Section {
                    NavigationLink(destination: MeetingView(scrum: $scrum,
                                                            scrumTimer: scrum.timer)) {
                        Label("Start Meeting", systemImage: "timer")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                    }.navigationTitle(scrum.title)
                    
                    HStack{
                        Label("Lenght", systemImage: "clock")
                        Spacer()
                        Text("\(scrum.lengthInMinutes) minutes")
                    }
                    .accessibilityElement(children: .combine)
                    
                    HStack {
                        Label("Theme", systemImage: "paintpalette")
                        Spacer()
                        Text(scrum.theme.name)
                            .padding(4)
                            .foregroundColor(scrum.theme.accentColor)
                            .background(scrum.theme.mainColor)
                            .cornerRadius(4)
                    }
                    .accessibilityElement(children: .combine)
                } header: {
                    Text("Meeting info")
                }
                
            //Atendee
                Section {
                    ForEach($scrum.attendees) { $item in
                        Label(item.name, systemImage: "person")
                    }
                } header: {
                    Text("Atendee")
                }
                
            //History
                Section {
                    ForEach(scrum.history) { history in
                        NavigationLink(destination: HistoryView(history: history)) {
                            HStack {
                                Image(systemName: "calendar")
                                Text(history.date, style: .date)
                                Text(" \(history.lengthInMinutes) minutes ")
                            }
                        }
                    }
                } header: {
                    if scrum.history.isEmpty {
                        Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                    } else {
                        Text("History")
                    }
                }
          }
        .toolbar {
            Button {
                isPresentingEditView = true
                data = scrum.data
            } label: {
                Text("Edit")
            }
        }
        
        //MARK: - Presenting Edit Detail
        .sheet(isPresented: $isPresentingEditView) {
            // on dismiss
        } content: {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                scrum.update(from: data)
                            }
                        }
                    }
            }
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
