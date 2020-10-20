//
//  SpaceXData.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import Alamofire
import os

// MARK: Utility function for UUID from string with no dashes
extension UUID {
    init?(stringWithoutDashes input: String) {
        var dashed = input
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 20))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 16))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 12))
        dashed.insert("-", at: input.index(input.startIndex, offsetBy: 8))
        
        self.init(uuidString: dashed.uppercased())
    }
}

// MARK: Custom date formatter for extended ISO8601 support.
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

class CustomDecoder: JSONDecoder {
    let dateFormatter = DateFormatter.iso8601Full
    
    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    }
}

// MARK: SpaceXData support class

/// Contains data obtained from the SpaceX API
final class SpaceXData: ObservableObject {
    
    // Variables
    
    
    // SpaceX data sections
    @Published public var launches = [Launch]()
    @Published public var crew = [Astronaut]()
    
    // Shared instance
    static var shared = SpaceXData()
    
    // Methods
    func loadCrew() {
        AF.request("https://api.spacexdata.com/v4/crew")
            .responseDecodable(of: [Astronaut].self, decoder: CustomDecoder()) { response in
                os_log("%d astronauts fetched", log: .spaceXData, type: .info, response.value?.count ?? 0)
                if let err = response.error {
                    os_log("Error while loading crew: \"%@\".", log: .spaceXData, type: .error, err as CVarArg)
                }
                if let res = response.value {
                    self.crew = res
                }
            }
    }

    func loadLaunches() {
        AF.request("https://api.spacexdata.com/v4/launches")
            .responseDecodable(of: [Launch].self, decoder: CustomDecoder()) { response in
                os_log("%d launches fetched", log: .spaceXData, type: .info, response.value?.count ?? 0)
                if let err = response.error {
                    os_log("Error while loading launches: \"%@\".", log: .spaceXData, type: .error, err as CVarArg)
                }
                if let res = response.value {
                    self.launches = res
                }
            }
    }
    
    /// Creates a new instance of `SpaceXData`.
    init() {
        loadLaunches()
        loadCrew()
    }
}
