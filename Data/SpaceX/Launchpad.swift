//
//  Launchpad.swift
//  Norminal
//
//  Created by Riccardo Persello on 27/10/2020.
//

import CoreLocation
import Foundation

// MARK: - Launchpad class

/// Represents a rocket launchpad
final class Launchpad: Decodable, ObservableObject, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/launchpads")!

    enum Status: String, Decodable {
        case retired
        case active
        case underConstruction = "under construction"
    }

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
    private var rocketIDs: [String]?

    public func getRockets(_ completion: @escaping ([Rocket]?) -> Void) {
        Rocket.loadFromArrayOfIdentifiers(ids: rocketIDs) { result in
            switch result {
                case .failure:
                    completion(nil)
                case .success(let rockets):
                    completion(rockets)
            }
        }
    }

    /// List of launch IDs that have started from this launchpad
    private var launchIDs: [String]?

    public func getLaunches(_ completion: @escaping ([Launch]?) -> Void) {
        Launch.loadFromArrayOfIdentifiers(ids: launchIDs) { result in
            switch result {
                case .failure:
                    completion(nil)
                case .success(let launches):
                    completion(launches)
            }
        }
    }

    /// Brief description of the launchpad
    public var details: String?

    /// Actual status of the launchpad
    public var status: Launchpad.Status

    /// Launchpad ID string
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case locality
        case region
        case timezone
        case latitude
        case longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rocketIDs = "rockets"
        case launchIDs = "launches"
        case details
        case status
        case stringID = "id"
    }

    // MARK: Launchpad weather

    // Static for persistence
    static var forecastsCache = NSCache<NSString, WeatherAPIResponse.WeatherAPIForecastHour>()

    public func getForecast(for date: Date, completion: @escaping (Result<WeatherAPIResponse.WeatherAPIForecastHour, Never>) -> Void) {
        if let cachedResponse = Launchpad.forecastsCache.object(forKey: "\(date.description)-\(stringID)" as NSString) {
            completion(.success(cachedResponse))
            return
        }

        WeatherAPI.shared.forecast(forLocation: location, at: date) { forecastResponse in
            switch forecastResponse {
            case let .success(result):
                if let hourlyForecast = result.getOnlyHourlyForecast() {
                    completion(.success(hourlyForecast))
                    Launchpad.forecastsCache.setObject(hourlyForecast, forKey: "\(date.description)-\(self.stringID)" as NSString)
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
    var id: UUID { return UUID(stringWithoutDashes: stringID)! }
}

extension Launchpad {
    /// Launchpad coordinates
    public var location: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
