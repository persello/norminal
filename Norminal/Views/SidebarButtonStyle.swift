//
//  SidebarButtonStyle.swift
//  Norminal
//
//  Created by Riccardo Persello on 28/03/21.
//

import Foundation

struct SidebarButtonStyle: ButtonStyle {
    private var isActive: Bool = false
    
    func getForegroundColor(configuration: Configuration) -> Color? {
        return configuration.isPressed ? .secondary : nil
    }
    
    func getBackgroundColor(configuration: Configuration) -> Color {
        if isActive {
            return Color(.secondarySystemFill)
        } else {
            return .clear
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(getForegroundColor(configuration: configuration))
            .padding(.vertical, 10)
            .padding(.leading, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                    .fill(getBackgroundColor(configuration: configuration))
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
            .padding(.horizontal, -8)
            .padding(.vertical, -10)
    }
    
    func active(_ a: Bool = true) -> SidebarButtonStyle {
        var style = self
        style.isActive = a
        return style
    }
}
