//
//  SatelliteKitExtensions.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/05/21.
//

import CoreLocation
import Foundation
import LASwift
import SatelliteKit

extension Satellite: Identifiable {
    public var id: String {
        return noradIdent
    }
}

// Support for Date
extension Satellite {
    private func jdFromDate(date: Date) -> Double {
        let JD_JAN_1_1970_0000GMT = 2440587.5
        return JD_JAN_1_1970_0000GMT + date.timeIntervalSince1970 / 86400
    }

    func coordinatesAndAltitude(date: Date) -> (CLLocationCoordinate2D, Double) {
        let longitudeAdjustment = 300.0

        let earthRadius = 6371.0 // Kilometers
        let position = self.position(julianDays: jdFromDate(date: date))

        let phi = atan2(sqrt(position.x.magnitudeSquared + position.y.magnitudeSquared), position.z)
        let theta = atan2(position.y, position.x)
        let absPhi = abs(phi)
        let phiSign = phi / absPhi

        let altitude = abs(earthRadius * 1000 - position.magnitude() * 1000)
        let latitude = ((Double.pi / 2) - absPhi) * 360 / (2 * .pi)
        let longitude = ((phiSign * theta * 360 / (2 * .pi)) + longitudeAdjustment + 180).truncatingRemainder(dividingBy: 360) - 180

        return (CLLocationCoordinate2D(latitude: latitude, longitude: longitude), altitude)
    }

    func location(date: Date = Date()) -> CLLocation {
        let currentCoordinates = coordinatesAndAltitude(date: date)

        let previousCoordinates = coordinatesAndAltitude(date: date.addingTimeInterval(-1))
        let deltaLatitude = currentCoordinates.0.latitude - previousCoordinates.0.latitude
        let deltaLongitude = currentCoordinates.0.longitude - previousCoordinates.0.longitude
        let course = atan2(deltaLongitude, deltaLatitude) * 360 / (2 * .pi)

        let velocity = self.velocity(julianDays: jdFromDate(date: date))

        return CLLocation(
            coordinate: currentCoordinates.0,
            altitude: currentCoordinates.1,
            horizontalAccuracy: 0,
            verticalAccuracy: 0,
            course: course,
            courseAccuracy: 0,
            speed: velocity.magnitude(),
            speedAccuracy: 0,
            timestamp: date)
    }
}
