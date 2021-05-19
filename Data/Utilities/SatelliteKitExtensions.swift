//
//  SatelliteKitExtensions.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/05/21.
//

import CoreLocation
import Foundation
import SatelliteKit

extension Satellite: Identifiable {
    public var id: String {
        return noradIdent
    }
}

// Support for Date
extension Satellite {
    func coordinates(date: Date = Date()) -> CLLocation {
        func jdFromDate(date: Date) -> Double {
            let JD_JAN_1_1970_0000GMT = 2440587.5
            return JD_JAN_1_1970_0000GMT + date.timeIntervalSince1970 / 86400
        }
        
        let longitudeAdjustment = 300.0

        let earthRadius = 6371.0 // Kilometers
        let position = self.position(julianDays: jdFromDate(date: date))
                
        let phi = atan2(sqrt(position.x.magnitudeSquared + position.y.magnitudeSquared), position.z)
        let absPhi = abs(phi)
        let phiSign = phi/absPhi
        
        let altitude = earthRadius - position.magnitude()
        let latitude = ((Double.pi / 2) - absPhi) * 360 / (2 * .pi)
        let longitude = ((phiSign * atan2(position.y, position.x) * 360 / (2 * .pi)) + longitudeAdjustment + 180).truncatingRemainder(dividingBy: 360) - 180
        
        
        return CLLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                          altitude: altitude,
                          horizontalAccuracy: 0,
                          verticalAccuracy: 0,
                          timestamp: date)
    }
}
