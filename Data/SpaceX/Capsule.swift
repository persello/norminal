//
//  Capsule.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Capsule: ObservableObject, Decodable {
    
    enum Status: String, Decodable {
        case unknown, active, retired, destroyed
    }
    
    public var serial: String
    
    public var status: Status
    
    public var type: String
    
    public var dragon: String?
    
    public var reuseCount: Int?
    
    public var waterLandings: Int?
    
    public var landLandings: Int?
    
    public var lastUpdate: String?
    
    private var launchIDs: [String]?
    
    public var launches: [Launch] {
        return SpaceXData.shared.launches.filter({
            if let id = $0.idstring {
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
        case dragon
        case reuseCount = "reuse_count"
        case waterLandings = "water_landings"
        case landLandings = "land_landings"
        case lastUpdate = "last_update"
        case launchIDs = "launches"
    }
}
