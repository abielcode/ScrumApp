//
//  ErrorWrapper.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 30/10/22.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID
    let error: Error
    let guidance: String

    init(error: Error, guidance: String) {
        self.id = UUID()
        self.error = error
        self.guidance = guidance
    }
}
