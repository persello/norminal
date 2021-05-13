//
//  Core.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Core: Decodable, ObservableObject {
    enum Status: String, Decodable {
        case active
        case inactive
        case unknown
        case expended
        case lost
        case retired
    }

    public var serial: String
    public var block: Int?
    public var status: Status
    public var reuseCount: Int?
    public var rtlsAttempts: Int?
    public var rtlsLandings: Int?
    public var asdsAttempts: Int?
    public var asdsLandings: Int?
    public var lastUpdate: String?
    private var launchIDs: [String]?
    public var stringID: String
    public var launches: [Launch] {
        if let launches = launchIDs?.compactMap({ id in
            SpaceXData.shared.launches.first(where: { launch in
                id == launch.stringID
            })
        }) {
            return launches
        } else {
            return []
        }
    }

    enum CodingKeys: String, CodingKey {
        case serial, block, status
        case reuseCount = "reuse_count"
        case rtlsAttempts = "rtls_attempts"
        case rtlsLandings = "rtls_landings"
        case asdsAttempts = "asds_attempts"
        case asdsLandings = "asds_landings"
        case lastUpdate = "last_update"
        case launchIDs = "launches"
        case stringID = "id"
    }
}

extension Core: Identifiable {
    var id: String { return stringID }
}
