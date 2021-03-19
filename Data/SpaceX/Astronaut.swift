//
//  Astronaut.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/10/2020.
//

import Foundation
import SwiftUI
import os

// MARK: - Astronaut class

/// Represents an astronaut
class Astronaut: Decodable {

  /// Name and surname of the astronaut
  public var name: String

  /// Name of the agency
  public var agency: String

  /// URL to a picture of the astronaut
  public var image: URL?

  /// Wikipedia article URL
  public var wikipedia: URL?

  /// List of launch IDs
  public var launches: [String]?

  /// Whether this astronaut is active or not
  public var status: String

  /// Astronaut ID
  public var idstring: String

  enum CodingKeys: String, CodingKey {
    case name = "name"
    case agency = "agency"
    case image = "image"
    case wikipedia = "wikipedia"
    case launches = "launches"
    case status = "status"
    case idstring = "id"
  }
}

// MARK: - Utility methods

extension Astronaut {
    /// Returns the initials of the astronaut
    func getInitials() -> String {
        let components = self.name.components(separatedBy: " ")
        return "\((components.first?.first)!)\((components.last?.first)!)"
    }
    
    /// Returns the launches in which this astronaut participated
    func getLaunches() -> [Launch]? {
        if let launchIdList = launches {
            var launches: [Launch] = []
            for launchID in launchIdList {
                if let launch = SpaceXData.shared.launches.first(where: { $0.idstring ?? "" == launchID }) {
                    launches.append(launch)
                }
            }
            
            if launches.count > 0 {
                return launches
            }
        }
        return nil
    }

}

// MARK: - Protocol extension

extension Astronaut: Identifiable {
  var id: UUID { return UUID(stringWithoutDashes: self.idstring)! }
}
