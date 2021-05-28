//
//  Landpad.swift
//  Norminal
//
//  Created by Riccardo Persello on 27/10/2020.
//

import Foundation
import CoreLocation

// MARK: - Landpad class

/// Represents a rocket Landpad
final class Landpad: Decodable, ObservableObject, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/landpads")!
    
    // MARK: - Enums
    
    enum Status: String, Decodable {
        case retired = "retired"
        case active = "active"
        case underConstruction = "under construction"
    }
    
    enum `Type`: String, Decodable {
        case RTLS
        case ASDS
    }

    /// Landpad official name
    public var name: String

    /// Landpad extended name
    public var fullName: String

    /// Landpad type
    public var type: Type

    /// Landpad locality
    public var locality: String

    /// Locality region
    public var region: String

    /// Landpad latitude
    public var latitude: Double

    /// Landpad longitude
    public var longitude: Double

    /// Number of landing attempts from this Landpad
    public var landingAttempts: Int

    /// Number of successful landinges from this Landpad
    public var landingSuccesses: Int

    /// Wikipedia article
    public var wikipedia: URL?

    /// List of launch IDs that have landed on this Landpad
    private var launchIDs: [String]?
    
    public var launches: [Launch]? {
        launchIDs?.compactMap({id in
            SpaceXData.shared.launches.first(where: { launch in
                launch.stringID == id
            })
        })
    }

    /// Brief description of the Landpad
    public var details: String?

    /// Actual status of the Landpad
    public var status: Status

    /// Landpad ID string
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case type = "type"
        case locality = "locality"
        case region = "region"
        case latitude = "latitude"
        case longitude = "longitude"
        case landingAttempts = "landing_attempts"
        case landingSuccesses = "landing_successes"
        case wikipedia = "wikipedia"
        case details = "details"
        case launchIDs = "launches"
        case status = "status"
        case stringID = "id"
    }
}

// MARK: - Protocol extensions

extension Landpad: Identifiable {
    /// Landpad ID
    var id: UUID { return UUID(stringWithoutDashes: self.stringID)! }
}

extension Landpad {
    /// Landpad coordinates
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
