//
//  PointOfInterest.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import CoreLocation
import Foundation
import SwiftUI

struct PointOfInterest: Identifiable {
    enum Kind: String {
        case droneship
        case launchpad
        case landpad
        case ship
    }

    let id = UUID()
    let coordinates: CLLocationCoordinate2D?
    let kind: Kind
    let name: String?
    let originalObject: Any?

    init(coordinates: CLLocationCoordinate2D?, kind: Kind, name: String? = nil, originalObject: Any? = nil) {
        self.coordinates = coordinates
        self.kind = kind
        self.name = name
        self.originalObject = originalObject
    }

    func getMarker(shadowRadius: CGFloat = 10) -> some View {
        switch kind {
        case .droneship:
            return TextMapMarkerView(
                text: (originalObject as? Ship)?.name.components(separatedBy: " ").map { String($0.prefix(1)) }.joined().uppercased() ??
                    (originalObject as? Landpad)?.name ??
                    "⤵️",
                shadowRadius: shadowRadius
            )
        case .landpad:
            return TextMapMarkerView(text: "⤵️", shadowRadius: shadowRadius)
        case .launchpad:
            return TextMapMarkerView(text: "🚀", shadowRadius: shadowRadius)
        case .ship:
            return TextMapMarkerView(text: "🛥", shadowRadius: shadowRadius)
        }
    }

    func getRolesString() -> String? {
        if let ship = originalObject as? Ship {
            if let roles = ship.roles {
                return ListFormatter.localizedString(byJoining: roles).capitalizingFirstLetter()
            }
        }
        return nil
    }
}
