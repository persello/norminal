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
    
    static var ultralightGray: Color {
        return Color(NSColor.lightGray.withSystemEffect(.disabled))
    }
    
    static var lightGray: Color {
        return Color(NSColor.lightGray)
    }
    
    static var systemGray: Color {
        return Color(NSColor.systemGray)
    }
    
    static var background: Color {
        return Color(NSColor.systemBackground)
    }
}

#elseif canImport(UIKit)
import UIKit

extension Color {
    static var tertiaryLabel: Color {
        return Color(UIColor.tertiaryLabel)
    }
    
    static var ultralightGray: Color {
        return Color(UIColor.systemGray6)
    }
    
    static var lightGray: Color {
        return Color(UIColor.systemGray4)
    }
    
    static var systemGray: Color {
        return Color(UIColor.systemGray)
    }
    
    static var background: Color {
        return Color(UIColor.systemBackground)
    }
}
#endif
