//
//  Launchpad.swift
//  Norminal
//
//  Created by Riccardo Persello on 27/10/2020.
//

import Foundation
import CoreLocation

// MARK: - Enums
enum LaunchpadStatus: String, Decodable {
    case retired = "retired"
    case active = "active"
    case underConstruction = "under construction"
}

// MARK: - Launchpad class

/// Represents a rocket launchpad
class Launchpad: Decodable, ObservableObject {

    /// Launchpad official name
    public var name: String

    /// Launchpad extended name
    public var fullName: String

    /// Launchpad locality
    public var locality: String

    /// Locality region
    public var region: String

    /// Locality timezone
    public var timezone: String

    /// Launchpad latitude
    public var latitude: Double

    /// Launchpad longitude
    public var longitude: Double

    /// Number of launch attempts from this launchpad
    public var launchAttempts: Int

    /// Number of successful launches from this launchpad
    public var launchSuccesses: Int

    /// List of rocket IDs that have been on this launchpad
    public var rockets: [String]?

    /// List of launch IDs that have started from this launchpad
    public var launches: [String]?

    /// Brief description of the launchpad
    public var details: String?

    /// Actual status of the launchpad
    public var status: LaunchpadStatus

    /// Launchpad ID string
    public var idstring: String

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case locality = "locality"
        case region = "region"
        case timezone = "timezone"
        case latitude = "latitude"
        case longitude = "longitude"
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets = "rockets"
        case details = "details"
        case status = "status"
        case idstring = "id"
    }
    
    // MARK: Launchpad weather
    
    // Static for persistence
    static var forecastsCache = NSCache<NSString, WeatherAPIResponse.WeatherAPIForecastHour>()
    
    public func getForecast(for date: Date, completion: @escaping (Result<WeatherAPIResponse.WeatherAPIForecastHour, Never>) -> Void) {
        if let cachedResponse = Launchpad.forecastsCache.object(forKey: "\(date.description)-\(self.idstring)" as NSString) {
            completion(.success(cachedResponse))
            return
        }
        
        WeatherAPI.shared.forecast(forLocation: self.location, at: date) { forecastResponse in
            switch forecastResponse {
                case .success(let result):
                    if let hourlyForecast = result.getOnlyHourlyForecast() {
                        completion(.success(hourlyForecast))
                        Launchpad.forecastsCache.setObject(hourlyForecast, forKey: "\(date.description)-\(self.idstring)" as NSString)
                    }
                default:
                    break
            }
        }
    }
}

// MARK: - Protocol extensions
extension Launchpad: Identifiable {
    /// Launchpad ID
    var id: UUID { return UUID(stringWithoutDashes: self.idstring)! }
}

extension Launchpad {
    /// Launchpad coordinates
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
