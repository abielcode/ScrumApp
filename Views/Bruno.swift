//
//  Bruno.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 20/10/22.
//

import SwiftUI

struct Bruno: View {
    var body: some View {
        VStack {
            HStack {
                Text("Nutella")
                Image(systemName: "cloud.sun.fill")
                    .renderingMode(.original)
                    .foregroundColor(.blue)
                    .font(.largeTitle)
            }
            HStack {
                Text("Bruno")
                Image(systemName: "person")
            }
            HStack {
                Text("Lucas")
                Image(systemName: "person")
            }
        }.background(Color.purple)
        //.shadow(color: .black, radius: 2, x: -2, y: 2)
    }
}

struct Bruno_Previews: PreviewProvider {
    static var previews: some View {
        Bruno()
    }
}
