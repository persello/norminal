//
//  SpaceXData.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import os
import WidgetKit

// MARK: - Utility extension for initializing UUID from string with no dashes
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

// MARK: - Custom date formatter for extended ISO8601 support.
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

// MARK: - Custom JSON date format decoder
class CustomDecoder: JSONDecoder {
    let dateFormatter = DateFormatter.iso8601Full
    
    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    }
}

// MARK: - SpaceXData main class

/// Contains data obtained from the SpaceX API
final class SpaceXData: ObservableObject {
    
    // Logger
    private var logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "SpaceX Data")
    
    // SpaceX data sections
    @Published public var launches = [Launch]()
    @Published public var crew = [Astronaut]()
    @Published public var launchpads = [Launchpad]()
    @Published public var landpads = [Landpad]()
    @Published public var rockets = [Rocket]()
    @Published public var capsules = [Capsule]()
    @Published public var companyInfo = CompanyInfo()
    @Published var loadingError: Bool = false
    
    // Shared instance
    static var shared = SpaceXData()
    
    // Methods
    func getNextLaunch() -> Launch? {
        return launches.first(where: {$0.upcoming})
    }
    
    // MARK: Generic function for loading data
    func loadData<T: Decodable>(url: URL) -> T {
        var result: T!
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            defer {semaphore.signal()}
            
            if let error = error {
                logger.error("Error while loading \(T.Type.self) from \(url.absoluteString) due to \"\(error as NSObject)\".")
                DispatchQueue.main.async {
                    loadingError = true
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                logger.error("Error while loading \(T.Type.self) from \(url.absoluteString): server returned non-200 status code.")
                DispatchQueue.main.async {
                    loadingError = true
                }
                return
            }
            
            if let data = data {
                do {
                    result = try CustomDecoder().decode(T.self, from: data)
                    logger.info("Loaded \(T.Type.self).")
                } catch {
                    logger.error("Error while decoding \(T.Type.self): \(error as NSObject).")
                    DispatchQueue.main.async {
                        loadingError = true
                    }
                }
            }
        }
        
        task.resume()
        
        _ = semaphore.wait(timeout: DispatchTime.now() + 10.0)
        return result
    }
    
    func loadAllData() {
        self.loadingError = false
        
        DispatchQueue.global(qos: .background).async {
            let queue = OperationQueue()
            queue.name = "com.persello.norminal.widget.concurrentTimelineGeneration"
            queue.qualityOfService = .background
            queue.maxConcurrentOperationCount = 8
            
            var _launches: [Launch]!
            queue.addOperation { [self] in
                _launches = loadData(url: URL(string: "https://api.spacexdata.com/v4/launches")!)
                
                // Sort launches
                _launches = _launches.sorted(by: {
                    // $0 not launched and $1 launched
                    if $0.upcoming && !$1.upcoming {
                        return false
                    } else if !$0.upcoming && $1.upcoming {
                        return true
                    } else {
                        // Considering tolerance
                        if let d0 = $0.dateAfterTolerance, let d1 = $1.dateAfterTolerance {
                            return d0.compare(d1) == .orderedAscending
                        }
                        return $0.dateUTC.compare($1.dateUTC) == .orderedAscending
                    }
                })
            }
            
            var _crew: [Astronaut]!
            queue.addOperation { [self] in
                _crew = loadData(url: URL(string: "https://api.spacexdata.com/v4/crew")!)
            }
            
            var _launchpads: [Launchpad]!
            queue.addOperation { [self] in
                _launchpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/launchpads")!)
            }
            
            var _landpads: [Landpad]!
            queue.addOperation { [self] in
                _landpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/landpads")!)
            }
            
            var _rockets: [Rocket]!
            queue.addOperation { [self] in
                _rockets = loadData(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
            }
            
            var _capsules: [Capsule]!
            queue.addOperation { [self] in
                _capsules = loadData(url: URL(string: "https://api.spacexdata.com/v4/capsules")!)
            }
            
            var _companyInfo: CompanyInfo!
            queue.addOperation { [self] in
                _companyInfo = loadData(url: URL(string: "https://api.spacexdata.com/v4/company")!)
            }
            
            queue.waitUntilAllOperationsAreFinished()
            
            // Sync
            DispatchQueue.main.async {
                self.launches = _launches
                self.crew = _crew
                self.launchpads = _launchpads
                self.landpads = _landpads
                self.rockets = _rockets
                self.capsules = _capsules
                self.companyInfo = _companyInfo
            }
        }
    }
    
    /// Creates a new instance of `SpaceXData`.
    init() {
        loadAllData()
    }
}
