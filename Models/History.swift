//
//  History.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 23/10/22.
//

import Foundation
struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lengthInMinutes: Int
    
    init(date: Date = Date(), attendees: [DailyScrum.Attendee], lengthInMinutes: Int = 5) {
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.id = UUID()
    }
}
