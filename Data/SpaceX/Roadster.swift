//
//  Roadster.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

final class Roadster: ObservableObject, Decodable, Fetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/roadster")!

    public var name: String?
    public var launchDate: Date?
    public var launchMass: Measurement<UnitMass>?
    public var noradID: Int?
    public var epochJD: Double?
    public var orbit: String?
    public var apoapsis: Measurement<UnitLength>?
    public var periapsis: Measurement<UnitLength>?
    public var semiMajorAxis: Measurement<UnitLength>?
    public var eccentricity: Double?
    public var inclination: Measurement<UnitAngle>?
    public var longitude: Measurement<UnitAngle>?
    public var periapsisArgument: Measurement<UnitAngle>?
    public var periodDays: Double?
    public var speed: Measurement<UnitSpeed>?
    public var earthDistance: Measurement<UnitLength>?
    public var marsDistance: Measurement<UnitLength>?
    public var flickrImages: [URL]?
    public var wikipedia: URL?
    public var video: URL?
    public var details: String?

    enum CodingKeys: String, CodingKey {
        case name
        case launchDate = "launch_date_utc"
        case launchMassKilograms = "launch_mass_kg"
        case noradID = "norad_id"
        case epochJD = "epoch_jd"
        case orbit = "orbit_type"
        case apoapsisAU = "apoapsis_au"
        case periapsisAU = "periapsis_au"
        case semiMajorAxisAU = "semi_major_axis_au"
        case eccentricity
        case inclinationDegrees = "inclination"
        case longitudeDegrees = "longitude"
        case periapsisArgumentDegrees = "periapsis_arg"
        case periodDays = "period_days"
        case speedKph = "speed_kph"
        case earthDistanceKilometers = "earth_distance_km"
        case marsDistanceKilometers = "mars_distance_km"
        case flickrImages = "flickr_images"
        case wikipedia, video, details
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try? values.decodeIfPresent(String.self, forKey: .name)
        launchDate = try? values.decodeIfPresent(Date.self, forKey: .launchDate)

        if let launchMassKilograms = try? values.decodeIfPresent(Double.self, forKey: .launchMassKilograms) {
            launchMass = .init(value: launchMassKilograms, unit: .kilograms)
        }

        noradID = try? values.decodeIfPresent(Int.self, forKey: .noradID)
        epochJD = try? values.decodeIfPresent(Double.self, forKey: .epochJD)
        orbit = try? values.decodeIfPresent(String.self, forKey: .orbit)

        if let apoapsisAU = try? values.decodeIfPresent(Double.self, forKey: .apoapsisAU) {
            apoapsis = .init(value: apoapsisAU, unit: .astronomicalUnits)
        }

        if let periapsisAU = try? values.decodeIfPresent(Double.self, forKey: .periapsisAU) {
            periapsis = .init(value: periapsisAU, unit: .astronomicalUnits)
        }

        if let semiMajorAxisAU = try? values.decodeIfPresent(Double.self, forKey: .semiMajorAxisAU) {
            semiMajorAxis = .init(value: semiMajorAxisAU, unit: .astronomicalUnits)
        }

        eccentricity = try? values.decodeIfPresent(Double.self, forKey: .eccentricity)

        if let inclinationDegrees = try? values.decodeIfPresent(Double.self, forKey: .inclinationDegrees) {
            inclination = .init(value: inclinationDegrees, unit: .degrees)
        }

        if let longitudeDegrees = try? values.decodeIfPresent(Double.self, forKey: .longitudeDegrees) {
            longitude = .init(value: longitudeDegrees, unit: .degrees)
        }

        if let periapsisArgumentDegrees = try? values.decodeIfPresent(Double.self, forKey: .periapsisArgumentDegrees) {
            periapsisArgument = .init(value: periapsisArgumentDegrees, unit: .degrees)
        }

        periodDays = try? values.decodeIfPresent(Double.self, forKey: .periodDays)

        if let speedKph = try? values.decodeIfPresent(Double.self, forKey: .speedKph) {
            speed = .init(value: speedKph, unit: .kilometersPerHour)
        }

        if let earthDistanceKilometers = try? values.decodeIfPresent(Double.self, forKey: .earthDistanceKilometers) {
            earthDistance = .init(value: earthDistanceKilometers, unit: .kilometers)
        }

        if let marsDistanceKilometers = try? values.decodeIfPresent(Double.self, forKey: .marsDistanceKilometers) {
            marsDistance = .init(value: marsDistanceKilometers, unit: .kilometers)
        }

        flickrImages = try? values.decodeIfPresent([URL].self, forKey: .flickrImages)
        wikipedia = try? values.decodeIfPresent(URL.self, forKey: .wikipedia)
        video = try? values.decodeIfPresent(URL.self, forKey: .video)
        details = try? values.decodeIfPresent(String.self, forKey: .details)
    }
}
