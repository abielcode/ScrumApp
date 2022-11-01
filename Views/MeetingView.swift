//
//  MeetingView.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 19/10/22.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer: ScrumTimer
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                         .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed,
                                  secondsRemaining: scrumTimer.secondsRemaining,
                                  theme: scrum.theme)
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme, isRecording: isRecording)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear(perform: {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes,
                             attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            isRecording = true
            scrumTimer.startScrum()
        })
        .onDisappear(perform: {
            let history = History(date: Date(), attendees: scrum.attendees, lengthInMinutes: scrum.lengthInMinutes)
            scrum.history.append(history)
            scrumTimer.stopScrum()
            speechRecognizer.stopTranscribing()
            isRecording = false

        })
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]), scrumTimer: DailyScrum.sampleData[0].timer)
    }
}
