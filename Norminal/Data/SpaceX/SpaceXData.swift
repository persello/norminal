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
import WidgetKit

// MARK: Utility function for UUID from string with no dashes
extension UUID {
  init?(stringWithoutDashes input: String) {
    var dashed = input
    while dashed.count < 32 {
      dashed.append("0")
    }
    
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
  
  // Logger
  private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SpaceX Data")
  
  // SpaceX data sections
  @Published public var launches = [Launch]()
  @Published public var crew = [Astronaut]()
  @Published public var launchpads = [Launchpad]()
  @Published public var landpads = [Landpad]()
  
  // Shared instance
  static var shared = SpaceXData()
  
  // Methods
  func getNextLaunch() -> Launch? {
    return launches.first(where: {$0.upcoming})
  }
  
  func loadData<T: Decodable>(url: URL) -> [T] {
    var result = Array<T>()
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
      defer{semaphore.signal()}
      
      if let error = error {
        logger.error("Error while loading \(T.Type.self) from \(url.absoluteString) due to \"\(error as NSObject)\".")
      }
      
      guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
        logger.error("Error while loading \(T.Type.self) from \(url.absoluteString): server returned non-200 status code.")
        return
      }
      
      if let data = data {
        do {
          let res = try CustomDecoder().decode([T].self, from: data)
          result.append(contentsOf: res)
          logger.info("Loaded \(res.count) \(T.Type.self).")
        } catch {
          logger.error("Error while decoding \(T.Type.self): \(error as NSObject).")
        }
      }
    }
    
    task.resume()
    
    _ = semaphore.wait(timeout: DispatchTime.now() + 10.0)
    return result
  }
  
  /// Creates a new instance of `SpaceXData`.
  init() {
    launches = loadData(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
    crew = loadData(url: URL(string: "https://api.spacexdata.com/v4/crew")!)
    launchpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/launchpads")!)
    landpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/landpads")!)
    
    launches = launches.sorted(by: {
      // $0 not launched and $1 launched
      if $0.upcoming && !$1.upcoming {
        return false
      } else if !$0.upcoming && $1.upcoming {
        return true
      } else {
        // TODO: Consider tolerance
        return $0.dateUTC.compare($1.dateUTC) == .orderedAscending
      }
    })
  }
}
