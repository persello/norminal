//
//  Rocket.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/03/21.
//

import Foundation

// MARK: - Rocket class

/// Represents a rocket launchpad
class Rocket: Decodable, ObservableObject {

    public var height: Measurement<UnitLength>

    /// Launchpad extended name
    public var fullName: String

    /// Launchpad locality
    public var locality: String

    /// Locality region
    public var region: String

    /// Locality timezone
    public var timezone: String

    /// Launchpad latitude
    public var latitude: Double

    /// Launchpad longitude
    public var longitude: Double

    /// Number of launch attempts from this launchpad
    public var launchAttempts: Int

    /// Number of successful launches from this launchpad
    public var launchSuccesses: Int

    /// List of rocket IDs that have been on this launchpad
    public var rockets: [String]?

    /// List of launch IDs that have started from this launchpad
    public var launches: [String]?

    /// Brief description of the launchpad
    public var details: String?

    /// Actual status of the launchpad
    public var status: LaunchpadStatus

    /// Launchpad ID string
    public var idstring: String

    
}
