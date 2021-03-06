//
//  SpaceXData.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import os
import SwiftUI
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
    override init() {
        super.init()
        dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            if let date = DateFormatter.iso8601Full.date(from: dateStr) {
                return date
            } else if let date = ISO8601DateFormatter().date(from: dateStr) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateStr).")
            }
        })
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
    @Published public var companyInfo: CompanyInfo?
    @Published public var cores = [Core]()
    @Published public var dragons = [Dragon]()
    @Published public var fairings = [Fairing]()
    @Published public var history = [HistoryEntry]()
    @Published public var payloads = [Payload]()
    @Published public var roadster: Roadster?
    @Published public var ships = [Ship]()
    @Published public var starlinks = [Starlink]()
    @Published var loadingError: Bool = false

    // Shared instance
    static var shared = SpaceXData()

    // Methods
    func getNextLaunch() -> Launch? {
        return launches.first(where: { $0.upcoming })
    }

    // MARK: Generic function for loading data

    func loadData<T: Decodable>(url: URL) -> T? {
        var result: T?
        let semaphore = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
            defer { semaphore.signal() }

            if let error = error {
                logger.error("Error while loading \(T.Type.self) from \(url.absoluteString) due to \"\(error as NSObject)\".")
                DispatchQueue.main.async {
                    loadingError = true
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200 ... 299).contains(httpResponse.statusCode) else {
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
        loadingError = false

        DispatchQueue.global(qos: .background).async {
            let queue = OperationQueue()
            queue.name = "com.persello.norminal.widget.concurrentTimelineGeneration"
            queue.qualityOfService = .background
            queue.maxConcurrentOperationCount = 8

            // MARK: Launches

            var _launches: [Launch]?
            queue.addOperation { [self] in
                _launches = loadData(url: URL(string: "https://api.spacexdata.com/v4/launches")!)

                // Sort launches
                _launches = _launches?.sorted(by: {
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

            // MARK: Crew

            var _crew: [Astronaut]?
            queue.addOperation { [self] in
                _crew = loadData(url: URL(string: "https://api.spacexdata.com/v4/crew")!)
            }

            // MARK: Launchpads

            var _launchpads: [Launchpad]?
            queue.addOperation { [self] in
                _launchpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/launchpads")!)
            }

            // MARK: Landpads

            var _landpads: [Landpad]?
            queue.addOperation { [self] in
                _landpads = loadData(url: URL(string: "https://api.spacexdata.com/v4/landpads")!)
            }

            // MARK: Rockets

            var _rockets: [Rocket]?
            queue.addOperation { [self] in
                _rockets = loadData(url: URL(string: "https://api.spacexdata.com/v4/rockets")!)
            }

            // MARK: Capsules

            var _capsules: [Capsule]?
            queue.addOperation { [self] in
                _capsules = loadData(url: URL(string: "https://api.spacexdata.com/v4/capsules")!)
            }

            // MARK: Company info

            var _companyInfo: CompanyInfo?
            queue.addOperation { [self] in
                _companyInfo = loadData(url: URL(string: "https://api.spacexdata.com/v4/company")!)
            }

            // MARK: Cores

            var _cores: [Core]?
            queue.addOperation { [self] in
                _cores = loadData(url: URL(string: "https://api.spacexdata.com/v4/cores")!)
            }

            // MARK: Dragons

            var _dragons: [Dragon]?
            queue.addOperation { [self] in
                _dragons = loadData(url: URL(string: "https://api.spacexdata.com/v4/dragons")!)
            }

            // MARK: Fairings

            var _fairings: [Fairing]?
            queue.addOperation { [self] in
                _fairings = loadData(url: URL(string: "https://api.spacexdata.com/v4/fairings")!)
            }

            // MARK: History

            var _history: [HistoryEntry]?
            queue.addOperation { [self] in
                _history = loadData(url: URL(string: "https://api.spacexdata.com/v4/history")!)
            }

            // MARK: Payloads

            var _payloads: [Payload]?
            queue.addOperation { [self] in
                _payloads = loadData(url: URL(string: "https://api.spacexdata.com/v4/payloads")!)
            }

            // MARK: Roadster

            var _roadster: Roadster?
            queue.addOperation { [self] in
                _roadster = loadData(url: URL(string: "https://api.spacexdata.com/v4/roadster")!)
            }

            // MARK: Ships

            var _ships: [Ship]?
            queue.addOperation { [self] in
                _ships = loadData(url: URL(string: "https://api.spacexdata.com/v4/ships")!)
            }

            // MARK: Starlink

            var _starlinks: [Starlink]?
            queue.addOperation { [self] in
                _starlinks = loadData(url: URL(string: "https://api.spacexdata.com/v4/starlink")!)
            }

            queue.waitUntilAllOperationsAreFinished()

            // Sync
            DispatchQueue.main.async {
                if let _launches = _launches {
                    self.launches = _launches
                }

                if let _crew = _crew {
                    self.crew = _crew
                }

                if let _launchpads = _launchpads {
                    self.launchpads = _launchpads
                }

                if let _landpads = _landpads {
                    self.landpads = _landpads
                }

                if let _rockets = _rockets {
                    self.rockets = _rockets
                }

                if let _capsules = _capsules {
                    self.capsules = _capsules
                }

                if let _companyInfo = _companyInfo {
                    self.companyInfo = _companyInfo
                }

                if let _cores = _cores {
                    self.cores = _cores
                }

                if let _dragons = _dragons {
                    self.dragons = _dragons
                }

                if let _fairings = _fairings {
                    self.fairings = _fairings
                }

                if let _history = _history {
                    self.history = _history
                }

                if let _payloads = _payloads {
                    self.payloads = _payloads
                }

                if let _roadster = _roadster {
                    self.roadster = _roadster
                }

                if let _ships = _ships {
                    self.ships = _ships
                }

                if let _starlinks = _starlinks {
                    self.starlinks = _starlinks
                }
            }
        }
    }

    /// Creates a new instance of `SpaceXData`.
    init() {
        loadAllData()
    }
}
