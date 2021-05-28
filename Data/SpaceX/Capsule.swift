//
//  Capsule.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

final class Capsule: ObservableObject, Decodable, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/capsules")!
    
    enum Status: String, Decodable {
        case unknown, active, retired, destroyed
    }

    public var serial: String

    public var status: Status

    public var type: String

    private var dragonID: String?

    public var dragonModel: Dragon? {
        if let dragonID = self.dragonID {
            // Not supported now, but might be when API gets fixed
            return SpaceXData.shared.dragons.first(where: { dragon in
                dragon.stringID == dragonID
            })
        } else {
            // Type matching
            // Ex. "Dragon 1" Dragon name matches with both "Dragon 1.1" and "Dragon 1.0" capsule types.

            return SpaceXData.shared.dragons.first(where: { dragon in
                self.type.starts(with: dragon.name) 
            })
        }
    }

    public var reuseCount: Int?

    public var waterLandings: Int?

    public var landLandings: Int?

    public var lastUpdate: String?

    private var launchIDs: [String]?

    public var stringID: String

    public var launches: [Launch] {
        return SpaceXData.shared.launches.filter({
            if let id = $0.stringID {
                return (launchIDs?.contains(id)) ?? false
            } else {
                return false
            }
        })
    }

    enum CodingKeys: String, CodingKey {
        case serial
        case status
        case type
        case dragonID = "dragon"
        case reuseCount = "reuse_count"
        case waterLandings = "water_landings"
        case landLandings = "land_landings"
        case lastUpdate = "last_update"
        case launchIDs = "launches"
        case stringID = "id"
    }
}

extension Capsule: Identifiable {
    var id: String { return stringID }
}

extension Capsule: Equatable {
    static func == (rhs: Capsule, lhs: Capsule) -> Bool {
        rhs.stringID == lhs.stringID
    }
}
