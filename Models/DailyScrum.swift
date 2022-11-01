//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 19/10/22.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []

    init(title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = UUID()
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
    init(data: Data) {
        self.id = UUID()
        self.title = data.title
        self.attendees = data.attendees
        self.lengthInMinutes = Int(data.lengthInMinutes)
        self.theme = data.theme
    }
    
    mutating func update(from: Data) {
        self.title = from.title
        self.attendees = from.attendees
        self.lengthInMinutes = Int(from.lengthInMinutes)
        self.theme = from.theme
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable, Equatable {
        let id: UUID
        let name: String
        
        init(name: String) {
            self.name = name
            self.id = UUID()
        }
    }
    
    struct Data: Equatable {
        static func == (lhs: DailyScrum.Data, rhs: DailyScrum.Data) -> Bool {
            return lhs.title == rhs.title && lhs.lengthInMinutes == rhs.lengthInMinutes && lhs.theme == rhs.theme && lhs.attendees == rhs.attendees
        }
        
        var title: String = ""
        var attendees: [Attendee] = []
        var lengthInMinutes: Double = 5
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(title: title, attendees: attendees, lengthInMinutes: Double(lengthInMinutes), theme: theme)
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 12, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
    ]
}
