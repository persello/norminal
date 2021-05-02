//
//  Fairing.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Fairing: ObservableObject, Decodable {
    enum Version: String, Decodable {
        case v1_0 = "1.0"
        case v2_0 = "2.0"
        case v2_1 = "2.1"
    }

    enum Status: String, Decodable {
        case active
        case inactive
        case unknown
        case expended
        case lost
        case retired
    }

    public var serial: String
    public var version: Version?
    public var status: Status
    public var reuseCount: Int?
    public var netLandingAttempts: Int?
    public var netLandings: Int?
    public var waterLandingAttempts: Int?
    public var waterLandings: Int?
    public var lastUpdate: String?
    private var launchIDs: [String]?
    public var launches: [Launch]? {
        launchIDs?.compactMap({ id in
            SpaceXData.shared.launches.first(where: { launch in
                launch.idstring == id
            })
        })
    }
    
    enum CodingKeys: String, CodingKey {
        case serial, version, status
        case reuseCount = "reuse_count"
        case netLandingAttempts = "net_landing_attempts"
        case netLandings = "net_landing"
        case waterLandingAttempts = "water_landing_attempts"
        case waterLandings = "water_landing"
        case lastUpdate = "last_update"
        case launchIDs = "launches"
    }
}
