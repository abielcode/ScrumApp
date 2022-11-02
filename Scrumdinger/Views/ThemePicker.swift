//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Boris Chirino on 22/10/22.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { item in
                ThemeView(theme: item)
                    .tag(item)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
