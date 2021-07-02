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

    public func getDragonModel(_ completion: @escaping (Dragon?) -> Void) {
        if let dragonID = self.dragonID {
            // Not supported now, but might be when API gets fixed
            Dragon.get(id: dragonID, completion)
        } else {
            // Type matching
            // Ex. "Dragon 1" Dragon name matches with both "Dragon 1.1" and "Dragon 1.0" capsule types.

            Dragon.loadAll { result in
                switch result {
                case .failure:
                    completion(nil)
                case let .success(dragons):
                    completion(dragons.first(where: { self.type.starts(with: $0.name) }))
                }
            }
        }
    }

    public var reuseCount: Int?

    public var waterLandings: Int?

    public var landLandings: Int?

    public var lastUpdate: String?

    private var launchIDs: [String]?

    public var stringID: String

    public func getLaunches(_ completion: @escaping ([Launch]?) -> Void) {
        Launch.loadOrdered { result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(launches):
                completion(launches.filter({ self.launchIDs?.contains($0.stringID) ?? false }))
            }
        }
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
