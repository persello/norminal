//
//  Launch.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import Telescope

// MARK: - Launch class

/// Represents a SpaceX launch.
final class Launch: Decodable, ObservableObject, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/launches")!

    static func loadOrdered(completion handler: @escaping (Result<[Launch], Error>) -> Void) {
        Launch.loadAll { result in
            switch result {
            case let .failure(error):
                handler(.failure(error))
            case let .success(launches):
                let orderedLaunches = launches.sorted(by: {
                    // $0 not launched and $1 launched
                    if $0.upcoming && !$1.upcoming {
                        return false
                    } else if !$0.upcoming && $1.upcoming {
                        return true
                    } else {
                        // Considering tolerance
                        if let d0 = $0.dateAfterTolerance,
                           let d1 = $1.dateAfterTolerance {
                            return d0.compare(d1) == .orderedAscending
                        }

                        return $0.dateUTC.compare($1.dateUTC) == .orderedAscending
                    }
                })

                handler(.success(orderedLaunches))
            }
        }
    }

    static func getNext(_ completion: @escaping (Launch?) -> Void) {
        loadOrdered { result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(launches):
                completion(launches.first(where: { $0.upcoming }))
            }
        }
    }
    
    static var next: Launch? {
        let group = DispatchGroup()
        var result: Launch?
        
        group.enter()
        getNext { launch in
            result = launch
            group.leave()
        }
        
        if group.wait(timeout: .now() + 15) == .timedOut {
            return nil
        }
        
        return result
    }

    // MARK: Enums

    enum DatePrecision: String, Decodable {
        case halfYear = "half"
        case quarterYear = "quarter"
        case year
        case month
        case day
        case hour
    }

    enum LandingType: String, Decodable {
        case ASDS
        case RTLS
        case ocean = "Ocean"
    }

    // MARK: - Support structs

    /// Represents a launch failure
    struct Failure: Decodable, Hashable {
        /// Relative time in seconds from/after T+0
        public var time: Int?

        /// Failure altitude
        public var altitude: Int?

        /// Failure desctiption (add "due to" in front of this string)
        public var reason: String?
    }

    /// Represents **a couple** of fairings.
    struct Fairings: Decodable {
        /// Whether the fairings are reused.
        public var reused: Bool?

        /// Whether a recovery of these fairings will be attempted.
        public var recoveryAttempt: Bool?

        /// Whether the recovery of the fairings has been successful.
        public var recovered: Bool?

        /// List of IDs of the ships used for the recovery actions as `String`s.
        private var shipIDs: [String]

        public func getShips(_ completion: @escaping ([Ship]?) -> Void) {
            Ship.loadFromArrayOfIdentifiers(ids: shipIDs) { result in
                switch result {
                    case .failure:
                        completion(nil)
                    case .success(let ships):
                        completion(ships)
                }
            }
        }

        enum CodingKeys: String, CodingKey {
            case reused
            case recoveryAttempt = "recovery_attempt"
            case recovered
            case shipIDs = "ships"
        }
    }

    /// Represents the instance of a core in a launch.
    struct CoreInstance: Decodable, Identifiable {
        /// The ID of this core as a `String`.
        public var id: String?

        /// The number of the current flight for this core.
        public var flight: Int?

        /// Whether this core is equipped with grid fins.
        public var gridFins: Bool?

        /// Whether this core is equipped with legs.
        public var legs: Bool?

        /// Whether this core is reused.
        public var reused: Bool?

        /// Whether a landing will be attempted.
        public var landingAttempt: Bool?

        /// Whether the landing was a success.
        public var landingSuccess: Bool?

        /// Indicates the landing type
        public var landingType: LandingType?

        /// The id of the landing pad as a `String`.
        private var landpadID: String?

        public func getLandpad(_ completion: @escaping (Landpad?) -> Void) {
            guard landpadID != nil else {
                completion(nil)
                return
            }

            Landpad.get(id: landpadID!, completion)
        }

        public func getRealCore(_ completion: @escaping (Core?) -> Void) {
            guard id != nil else {
                completion(nil)
                return
            }

            Core.get(id: id!, completion)
        }

        public func getNameDotFlight(_ completion: @escaping (String?) -> Void) {
            getRealCore { core in
                guard core != nil else {
                    completion(nil)
                    return
                }

                if let flight = flight,
                   let serial = core?.serial,
                   let reused = reused,
                   reused {
                    completion("\(serial).\(flight)")
                } else {
                    completion(core?.serial ?? "Unknown core")
                }
            }
        }

        public func getRecoveryStatus(_ completion: @escaping (String?) -> Void) {
            getLandpad { landpad in
                guard landpad != nil else {
                    completion(nil)
                    return
                }

                if landingAttempt ?? false {
                    if landingSuccess ?? false {
                        completion("Recovered (\(landpad?.name ?? landingType?.rawValue ?? "Unknown landing site"))")
                    } else {
                        completion("Recovery failed")
                    }
                } else {
                    completion("Expendable\((gridFins ?? false) ? "" : ", no fins")\((gridFins ?? false) ? "" : ", no legs")")
                }
            }
        }

        enum CodingKeys: String, CodingKey {
            case id = "core"
            case flight
            case gridFins = "grid_fins"
            case legs
            case reused
            case landingAttempt = "landing_attempt"
            case landingSuccess = "landing_success"
            case landingType = "landing_type"
            case landpadID = "landpad"
        }
    }

    struct Links: Decodable {
        struct Patch: Decodable {
            /// Low-resolution mission patch.
            public var small: URL?

            /// High-resolution mission patch.
            public var large: URL?

            enum CodingKeys: String, CodingKey {
                case small
                case large
            }
        }

        struct Reddit: Decodable {
            /// Campaign thread on Reddit.
            public var campaign: URL?

            /// Launch resources on Reddit.
            public var launch: URL?

            /// Media resources on Reddit.
            public var media: URL?

            /// recovery resources on Reddit.
            public var recovery: URL?

            enum CodingKeys: String, CodingKey {
                case campaign
                case launch
                case media
                case recovery
            }
        }

        struct Flickr: Decodable {
            /// Collection of low resolution images for this mission.
            public var smallImages: [URL]?

            /// Collection of original size images for this mission.
            public var originalImages: [URL]?

            enum CodingKeys: String, CodingKey {
                case smallImages = "small"
                case originalImages = "original"
            }
        }

        /// Mission patch resources.
        public var patch: Patch?

        /// Reddit mission coverage.
        public var reddit: Reddit?

        /// Flickr media.
        public var flickr: Flickr?

        /// Press kit.
        public var pressKit: URL?

        /// Official webcast.
        public var webcast: URL?

        /// YouTube webcast ID.
        public var youtubeID: String?

        /// News article.
        public var article: URL?

        /// Wikipedia page.
        public var wikipedia: URL?

        enum CodingKeys: String, CodingKey {
            case patch
            case reddit
            case flickr
            case pressKit
            case webcast
            case youtubeID = "youtube_id"
            case article
            case wikipedia
        }
    }

    /// **(Required)** The ordinal number of this launch.
    public var flightNumber: Int

    /// **(Required, unique)** The name of this launch's mission.
    public var name: String

    /// **(Required)** The date of the liftoff for this launch.
    public var dateUTC: Date

    /// **(Required)** The UNIX date of the liftoff for this launch.
    public var dateUNIX: UInt

    /// **(Required)** The date of the liftoff in the launchpad local time zone.
    // public var dateLocal: Date

    /// **(Required)** The launch date precision.
    public var datePrecision: DatePrecision

    /// The static fire's date.
    public var staticFireDateUTC: Date?

    /// The static fire's date in UNIX format.
    public var staticFireDateUNIX: UInt?

    /// Whether the launch date is still to be determined. Defaults to `false`.
    public var TBD: Bool = false

    /// Whether the launch date means no earlier than. Defaults to `false`.
    public var NET: Bool = false

    /// Represents the launch window.
    public var window: Int?

    /// Contains the ID of the rocket as a `String`.
    private var rocketID: String?

    /// Represents whether the launch was a success or not. Has no value until the launch ends.
    public var success: Bool?

    /// Contains a list of descriptions of the failures happened during this launch.
    public var failures: [Failure]?

    /// Whether the launch is upcoming. Defaults to `true`.
    public var upcoming: Bool

    /// The description of this launch's mission.
    private var unfilteredDetails: String?
    public var details: String? {
        guard let unfiltered = unfilteredDetails else {
            return nil
        }

        let pattern = #"\[\w*\]"#
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let mString = NSMutableString(string: unfiltered)
        regex.replaceMatches(in: mString, options: [], range: NSMakeRange(0, mString.length), withTemplate: "")
        let result = String(mString)
        return result
    }

    /// The fairings' details. Has no value in case of Dragon.
    public var fairings: Fairings?

    /// List of crew IDs as `String`s.
    private var crewIDs: [String]?

    /// List of ship IDs as `String`s.
    private var shipIDs: [String]?

    /// List of capsule IDs as `String`s.
    private var capsuleIDs: [String]?

    /// List of payload IDs as `String`s.
    private var payloadIDs: [String]?

    /// Launchpad ID as a `String`.
    private var launchpadID: String?

    /// List of cores.
    public var cores: [CoreInstance]?

    /// Internet resources for this launch.
    public var links: Links?

    /// Whether information is automatically updated. Defaults to `true`.
    public var autoUpdate: Bool = true

    /// UUID string
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUNIX = "date_unix"
        // case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUNIX = "static_fire_date_unix"
        case TBD = "tbd"
        case NET = "net"
        case window
        case rocketID = "rocket"
        case success
        case failures
        case upcoming
        case unfilteredDetails = "details"
        case fairings
        case crewIDs = "crew"
        case shipIDs = "ships"
        case capsuleIDs = "capsules"
        case payloadIDs = "payloads"
        case launchpadID = "launchpad"
        case cores
        case links
        case autoUpdate = "auto_update"
        case stringID = "id"
    }
}

// MARK: - Computed properties

extension Launch {
    var coresToRecover: Int {
        cores?.filter({ $0.landingAttempt ?? false }).count ?? 0
    }

    var coresRecovered: Int {
        cores?.filter({ ($0.landingSuccess ?? false) }).count ?? 0
    }

    public func isNextLaunch(_ completion: @escaping (Bool) -> Void) {
        Launch.getNext { launch in
            if let nl = launch {
                completion(self == nl)
                return
            }

            completion(false)
            return
        }
    }

    /// Use only for ordering! Returns a wrong date useful only for setting the launch order
    var dateAfterTolerance: Date? {
        switch datePrecision {
        case .hour:
            return Calendar.current.date(byAdding: .hour, value: 1, to: dateUTC)
        case .halfYear:
            return Calendar.current.date(byAdding: .month, value: 6, to: dateUTC)
        case .quarterYear:
            return Calendar.current.date(byAdding: .month, value: 3, to: dateUTC)
        case .year:
            return Calendar.current.date(byAdding: .year, value: 1, to: dateUTC)
        case .month:
            return Calendar.current.date(byAdding: .month, value: 1, to: dateUTC)
        case .day:
            return Calendar.current.date(byAdding: .day, value: 1, to: dateUTC)
        }
    }

    // MARK: - Properties obtained from UUIDs

    public func getRocket(_ completion: @escaping (Rocket?) -> Void) {
        guard rocketID != nil else {
            completion(nil)
            return
        }

        Rocket.get(id: rocketID!, completion)
    }

    public func getLaunchpad(_ completion: @escaping (Launchpad?) -> Void) {
        guard launchpadID != nil else {
            completion(nil)
            return
        }

        Launchpad.get(id: launchpadID!, completion)
    }

    public func getLandpads(_ completion: @escaping ([(CoreInstance, Landpad?)]?) -> Void) {
        guard cores?.count ?? 0 > 0 else {
            completion(nil)
            return
        }

        DispatchQueue.global(qos: .background).async {
            let group = DispatchGroup()
            var result: [(CoreInstance, Landpad?)] = []

            for core in self.cores! {
                group.enter()
                core.getLandpad { landpad in
                    result.append((core, landpad))
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                completion(result)
            }
        }
    }

    public func getCrew(_ completion: @escaping ([Astronaut]?) -> Void) {
        guard crewIDs?.count ?? 0 > 0 else {
            completion(nil)
            return
        }

        Astronaut.loadAll { [self] result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(astronauts):
                completion(astronauts.filter({ crewIDs?.contains($0.stringID) ?? false }))
            }
        }
    }

    public func getPayloads(_ completion: @escaping ([Payload]?) -> Void) {
        Payload.loadFromArrayOfIdentifiers(ids: payloadIDs) { result in
            switch result {
                case .failure:
                    completion(nil)
                case .success(let payloads):
                    completion(payloads)
            }
        }
    }

    public func getShips(_ completion: @escaping ([Ship]?) -> Void) {
        Ship.loadFromArrayOfIdentifiers(ids: shipIDs) { result in
            switch result {
                case .failure:
                    completion(nil)
                case .success(let ships):
                    completion(ships)
            }
        }
    }
}

// MARK: - Utility methods

extension Launch {
    func getImage(atIndex index: Int) -> RemoteImage? {
        guard index < (links?.flickr?.originalImages?.count ?? 0) - 1 else {
            return nil
        }

        if let url = links?.flickr?.originalImages![index] {
            return RemoteImage(imageURL: url)
        } else {
            return nil
        }
    }

    func getPatch() -> RemoteImage? {
        if let patchURL = links?.patch?.large {
            return RemoteImage(imageURL: patchURL)
        } else {
            return nil
        }
    }

    func getNiceDate(usePrecision: Bool) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent

        var result: String = ""

        // For standard dates, use maximum precision
        var precision = datePrecision
        if usePrecision == false {
            precision = DatePrecision.hour
        }

        switch precision {
        case .year:
            formatter.dateFormat = "yyyy"
            result = formatter.string(from: dateUTC)

        case .halfYear:
            let yearPeriod = dateUTC.get(.month) <= 6 ? "First half" : "Second half"
            formatter.dateFormat = "yyyy"
            result = "\(yearPeriod) of \(formatter.string(from: dateUTC))"

        case .quarterYear:
            var yearPeriod: String = "Sometime in"
            switch dateUTC.get(.month) {
            case 1 ... 3:
                yearPeriod = "First quarter"
            case 4 ... 6:
                yearPeriod = "Second quarter"
            case 7 ... 9:
                yearPeriod = "Third quarter"
            case 9 ... 12:
                yearPeriod = "Fourth quarter"
            default:
                break
            }
            formatter.dateFormat = "yyyy"
            result = "\(yearPeriod) of \(formatter.string(from: dateUTC))"

        case .month:
            formatter.setLocalizedDateFormatFromTemplate("yyyyMMMM")
            result = formatter.string(from: dateUTC)
        case .day:
            formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMd")
            result = formatter.string(from: dateUTC)
        case .hour:
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            result = formatter.string(from: dateUTC)
        }

        return result
    }
}

// MARK: - Protocol extensions

extension Launch: Identifiable {
    var id: Int { return flightNumber }
}

extension Launch: Equatable {
    static func == (lhs: Launch, rhs: Launch) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Launch: CustomStringConvertible {
    var description: String {
        return name
    }
}

// MARK: - Date extension for getting individual components

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
