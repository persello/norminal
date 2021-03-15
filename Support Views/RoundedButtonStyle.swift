//
//  RoundedButtonStyle.swift
//  Norminal
//
//  Created by Riccardo Persello on 14/10/2020.
//

import Foundation
import SwiftUI

struct RoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.callout.weight(.bold))
            .textCase(.uppercase)
            .foregroundColor(.accentColor)
            .padding(.vertical, 6)
            .padding(.horizontal, 24)
            .background(
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGray5))
                    .cornerRadius(15)
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}, label: {
            Text("Press me")
        })
        .buttonStyle(RoundedButtonStyle())
        .previewLayout(.sizeThatFits)
    }
}
