//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 22/10/22.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    
    var body: some View {
        NavigationView {
            Form {
            //title
            Section {
                if #available(iOS 15.0, *) {
                    TextField("Title",
                              text: $data.title,
                              prompt: Text("Scrum description"))
                } else {
                    TextField("Title", text: $data.title)
                }
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    Spacer()
                    Text("\(Int(data.lengthInMinutes)) minutes")
                }
                ThemePicker(selection: $data.theme)
            } header: {
                Text("Section Header")
            }
            
            //atendeee
            Section {
                ForEach(data.attendees) { atendee in
                    Text(atendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New atendee", text: $newAttendeeName)
                    Button {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add atendee")
                    }
                    .disabled(newAttendeeName.isEmpty && data.title.isEmpty)
                }
            } header: {
                Text("Atendee")
            }
        }
        }
 
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
        }
    }
}
