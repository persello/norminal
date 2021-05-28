//
//  Starlink.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import CoreLocation
import Foundation
import SatelliteKit

final class Starlink: ObservableObject, Decodable, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/starlink")!

    struct SpaceTrack: Decodable {
        private var TLE_LINE0: String?
        private var TLE_LINE1: String?
        private var TLE_LINE2: String?
        private var DECAYED: Int?
        private var DECAY_DATE: String?
    }

    public var version: String?
    private var launchID: String?
    public var launch: Launch? {
        SpaceXData.shared.launches.first(where: { $0.stringID == launchID })
    }

    private var latitude: Double?
    private var longitude: Double?
    private var heightKilometers: Double?
    public var location: CLLocation? {
        if let lat = latitude,
           let lon = longitude,
           let height = heightKilometers {
            return CLLocation(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                              altitude: height * 1000,
                              horizontalAccuracy: 0, verticalAccuracy: 0, timestamp: Date())
        }

        return nil
    }

    private var velocityKps: Double?
    public var velocity: Measurement<UnitSpeed>? {
        if let v = velocityKps {
            return .init(value: v * 3600, unit: .kilometersPerHour)
        }

        return nil
    }

    public var spaceTrack: SpaceTrack?
    

    enum CodingKeys: String, CodingKey {
        case version
        case launchID = "launch"
        case latitude, longitude
        case heightKilometers = "height_km"
        case velocityKps = "velocity_kps"
        case spaceTrack
    }
}

extension Starlink.SpaceTrack {
    var tle: TLE? {
        if let l0 = TLE_LINE0,
           let l1 = TLE_LINE1,
           let l2 = TLE_LINE2 {
            return try? TLE(l0, l1, l2)
        }

        return nil
    }

    var tleString: String? {
        if let l0 = TLE_LINE0,
           let l1 = TLE_LINE1,
           let l2 = TLE_LINE2 {
            return """
            \(l0)
            \(l1)
            \(l2)
            """
        }

        return nil
    }
    
    var decayed: Bool {
        return DECAYED ?? 0 > 0
    }
    
    var decayDate: String? {
        return DECAY_DATE
    }
}
