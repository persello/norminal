//
//  Launch.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import Telescope

#if canImport(UIKit)
import UIKit
#endif

// MARK: Enums
enum LaunchDatePrecision: String, Decodable {
    case halfYear = "half"
    case quarterYear = "quarter"
    case year = "year"
    case month = "month"
    case day = "day"
    case hour = "hour"
}

enum LandingType: String, Decodable {
    case ASDS = "ASDS"
    case RTLS = "RTLS"
    case ocean = "Ocean"
}

// MARK: - Support structs

/// Represents a launch failure
struct Failure: Decodable {
    
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
    public var ships: [String]
    
    enum CodingKeys: String, CodingKey {
        case reused = "reused"
        case recoveryAttempt = "recovery_attempt"
        case recovered = "recovered"
        case ships = "ships"
    }
}

/// Represents the instance of a core in a launch.
struct LaunchCore: Decodable, Identifiable {
    
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
    public var landPad: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "core"
        case flight = "flight"
        case gridFins = "grid_fins"
        case legs = "legs"
        case reused = "reused"
        case landingAttempt = "landing_attempt"
        case landingSuccess = "landing_success"
        case landingType = "landing_type"
        case landPad = "landpad"
    }
}

struct LaunchLinks: Decodable {
    
    /// Mission patch resources.
    public var patch: PatchLinks?
    
    /// Reddit mission coverage.
    public var reddit: RedditLinks?
    
    /// Flickr media.
    public var flickr: FlickrLinks?
    
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

struct PatchLinks: Decodable {
    
    /// Low-resolution mission patch.
    public var small: URL?
    
    /// High-resolution mission patch.
    public var large: URL?
    
    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
    
}

struct RedditLinks: Decodable {
    
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

struct FlickrLinks: Decodable {
    
    /// Collection of low resolution images for this mission.
    public var smallImages: [URL]?
    
    /// Collection of original size images for this mission.
    public var originalImages: [URL]?
    
    enum CodingKeys: String, CodingKey {
        case smallImages = "small"
        case originalImages = "original"
    }
}

// MARK: Launch struct

/// Represents a SpaceX launch.
class Launch: Decodable, ObservableObject {
    
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
    public var datePrecision: LaunchDatePrecision
    
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
    public var rocket: String?
    
    /// Represents whether the launch was a success or not. Has no value until the launch ends.
    public var success: Bool?
    
    /// Contains a list of descriptions of the failures happened during this launch.
    public var failures: [Failure]?
    
    /// Whether the launch is upcoming. Defaults to `true`.
    public var upcoming: Bool
    
    /// The description of this launch's mission.
    public var details: String?
    
    /// The fairings' details. Has no value in case of Dragon.
    public var fairings: Fairings?
    
    /// List of crew IDs as `String`s.
    public var crew: [String]?
    
    /// List of ship IDs as `String`s.
    public var ships: [String]?
    
    /// List of capsule IDs as `String`s.
    public var capsules: [String]?
    
    /// List of payload IDs as `String`s.
    public var payloads: [String]?
    
    /// List of launchpad IDs as a `String`.
    public var launchpad: String?
    
    /// List of cores.
    public var cores: [LaunchCore]?
    
    /// Internet resources for this launch.
    public var links: LaunchLinks?
    
    /// Whether information is automatically updated. Defaults to `true`.
    public var autoUpdate: Bool = true
    
    /// UUID string
    public var idstring: String?
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case name = "name"
        case dateUTC = "date_utc"
        case dateUNIX = "date_unix"
        // case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUNIX = "static_fire_date_unix"
        case TBD = "tbd"
        case NET = "net"
        case window = "window"
        case rocket = "rocket"
        case success = "success"
        case failures = "failures"
        case upcoming = "upcoming"
        case details = "details"
        case fairings = "fairings"
        case crew = "crew"
        case ships = "ships"
        case capsules = "capsules"
        case payloads = "payloads"
        case launchpad = "launchpad"
        case cores = "cores"
        case links = "links"
        case autoUpdate = "auto_update"
        case idstring = "id"
    }
    
    // MARK: - Utility methods
    var coresToRecover: Int {
        cores?.filter({$0.landingAttempt ?? false}).count ?? 0
    }
    
    var coresRecovered: Int {
        cores?.filter({($0.landingSuccess ?? false)}).count ?? 0
    }
    
    var isNextLaunch: Bool {
        if let nl = SpaceXData.shared.getNextLaunch() {
            return self == nl
        }
        return false
    }
    
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
    
    func getLaunchpad() -> Launchpad? {
        
        if launchpad != nil {
            return SpaceXData.shared.launchpads.first(where: { $0.idstring == launchpad! })
        }
        
        return nil
    }
    
    func getLandpads() -> [(LaunchCore, Landpad?)]? {
        if cores != nil {
            return cores!.map { core in
                (core, SpaceXData.shared.landpads.first(where: { $0.idstring == core.landPad }))
            }
        }
        
        return nil
    }
    
    func getCrew() -> [Astronaut]? {
        if let crewIdList = crew {
            var astronauts: [Astronaut] = []
            for astronautID in crewIdList {
                if let astronaut = SpaceXData.shared.crew.first(where: { $0.idstring == astronautID }) {
                    astronauts.append(astronaut)
                }
            }
            
            if astronauts.count > 0 {
                return astronauts
            }
        }
        return nil
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
    
    func getNiceDate(usePrecision: Bool) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.autoupdatingCurrent
        
        var result: String = ""
        
        // For standard dates, use maximum precision
        var precision = self.datePrecision
        if usePrecision == false {
            precision = LaunchDatePrecision.hour
        }
        
        switch precision {
            
            case .year:
                formatter.dateFormat = "yyyy"
                result = formatter.string(from: self.dateUTC)
                
            case .halfYear:
                let yearPeriod = self.dateUTC.get(.month) <= 6 ? "First half" : "Second half"
                formatter.dateFormat = "yyyy"
                result = "\(yearPeriod) of \(formatter.string(from: self.dateUTC))"
                
            case .quarterYear:
                var yearPeriod: String = "Sometime in"
                switch self.dateUTC.get(.month) {
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
                result = "\(yearPeriod) of \(formatter.string(from: self.dateUTC))"
                
            case .month:
                formatter.setLocalizedDateFormatFromTemplate("yyyyMMMM")
                result = formatter.string(from: self.dateUTC)
            case .day:
                formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMd")
                result = formatter.string(from: self.dateUTC)
            case .hour:
                formatter.dateStyle = .short
                formatter.timeStyle = .short
                result = formatter.string(from: self.dateUTC)
        }
        
        return result
    }
    
}

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
