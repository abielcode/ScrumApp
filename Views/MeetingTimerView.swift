//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 30/10/22.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool
    private var currentSpeaker: String {
        speakers.first(where: {!$0.isCompleted})?.name ?? "Unknown"
    }
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .padding()
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                                    .rotation(Angle(degrees: -90))
                                    .stroke(.white, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {
    static var speakers: [ScrumTimer.Speaker] {[
        ScrumTimer.Speaker(name: "John Silver", isCompleted: false),
        ScrumTimer.Speaker(name: "Mary Connor", isCompleted: false),
        ScrumTimer.Speaker(name: "Lady G", isCompleted: true)
        ]
    }
    
    static var previews: some View {
        MeetingTimerView(speakers: MeetingTimerView_Previews.speakers,
                         theme: .bubblegum,
                         isRecording: false)
    }
}
