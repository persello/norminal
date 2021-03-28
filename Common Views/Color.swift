//
//  Color.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

#if canImport(Cocoa)
import Cocoa

extension Color {
    static var tertiaryLabel: Color {
        return Color(NSColor.tertiaryLabelColor)
    }
    
    static var lightGray: Color {
        return Color(NSColor.lightGray)
    }
    
    static var systemGray: Color {
        return Color(NSColor.systemGray)
    }
}

#elseif canImport(UIKit)
import UIKit

extension Color {
    static var tertiaryLabel: Color {
        return Color(UIColor.tertiaryLabel)
    }
    
    static var lightGray: Color {
        return Color(UIColor.lightGray)
    }
    
    static var systemGray: Color {
        return Color(UIColor.systemGray)
    }
}
#endif
