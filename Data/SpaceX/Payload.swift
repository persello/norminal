//
//  Payload.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Payload: ObservableObject, Decodable {
    struct Dragon {
        private var capsuleID: String?
        public var capsule: Capsule? {
            SpaceXData.shared.capsules.first(where: {
                $0.stringID == capsuleID
            })
        }

        public var massReturned: Measurement<UnitMass>?
        public var flightTime: Measurement<UnitDuration>?
        public var manifest: URL?
        public var waterLanding: Bool?
        public var landLanding: Bool?

        enum CodingKeys: String, CodingKey {
            case capsuleID = "capsule"
            case massReturnedKilograms = "mass_returned_kg"
            case flightTimeSeconds = "flight_time_sec"
            case manifest
            case waterLanding = "water_landing"
            case landLanding = "land_landing"
        }
    }

    public var name: String?
    public var type: String?
    public var reused: Bool?
    private var launchID: String?
    public var launch: Launch? {
        SpaceXData.shared.launches.first(where: {
            $0.stringID == launchID
        })
    }

    public var customers: [String]?
    public var noradIDs: [Int]?
    public var nationalities: [String]?
    public var manufacturers: [String]?
    public var mass: Measurement<UnitMass>?
    public var orbit: String?
    public var referenceSystem: String?
    public var regime: String?
    public var longitude: Measurement<UnitAngle>?
    public var semiMajorAxis: Measurement<UnitLength>?
    public var eccentricity: Double?
    public var periapsis: Measurement<UnitLength>?
    public var apoapsis: Measurement<UnitLength>?
    public var inclination: Measurement<UnitAngle>?
    public var period: Measurement<UnitDuration>?
    public var lifespanYears: Double?
    public var epoch: Date?
    public var meanMotion: Double?
    public var raan: Measurement<UnitAngle>?
    public var argumentOfPericenter: Measurement<UnitAngle>?
    public var meanAnomaly: Measurement<UnitAngle>?
    public var dragon: Payload.Dragon?
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case name, type, reused
        case launchID = "launch"
        case customers
        case noradIDs = "norad_ids"
        case nationalities, manufacturers
        case massKilograms = "mass_kg"
        case orbit
        case referenceSystem = "reference_system"
        case regime
        case longitudeDegrees = "longitude"
        case semiMajorAxisKilometers = "semi_major_axis_km"
        case eccentricity
        case periapsisKilometers = "periapsis_km"
        case apoapsisKilometers = "apoapsis_km"
        case inclinationDegrees = "inclination_deg"
        case periodMinutes = "period_min"
        case lifespanYears = "lifespan_years"
        case epoch
        case meanMotion = "mean_motion"
        case raanDegrees = "raan"
        case argumentOfPericenterDegrees = "arg_of_pericenter"
        case meanAnomalyDegrees = "mean_anomaly"
        case dragon
        case stringID = "id"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try? values.decodeIfPresent(String.self, forKey: .name)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        reused = try? values.decodeIfPresent(Bool.self, forKey: .reused)
        launchID = try? values.decodeIfPresent(String.self, forKey: .launchID)
        customers = try? values.decodeIfPresent([String].self, forKey: .customers)
        noradIDs = try? values.decodeIfPresent([Int].self, forKey: .noradIDs)
        nationalities = try? values.decodeIfPresent([String].self, forKey: .nationalities)
        manufacturers = try? values.decodeIfPresent([String].self, forKey: .manufacturers)

        if let massKilograms = try? values.decodeIfPresent(Double.self, forKey: .massKilograms) {
            mass = .init(value: massKilograms, unit: .kilograms)
        }

        orbit = try? values.decodeIfPresent(String.self, forKey: .orbit)
        referenceSystem = try? values.decodeIfPresent(String.self, forKey: .referenceSystem)
        regime = try? values.decodeIfPresent(String.self, forKey: .regime)

        if let longitudeDegrees = try? values.decodeIfPresent(Double.self, forKey: .longitudeDegrees) {
            longitude = .init(value: longitudeDegrees, unit: .degrees)
        }

        if let semiMajorAxisKilometers = try? values.decodeIfPresent(Double.self, forKey: .semiMajorAxisKilometers) {
            semiMajorAxis = .init(value: semiMajorAxisKilometers, unit: .kilometers)
        }

        eccentricity = try? values.decode(Double.self, forKey: .eccentricity)

        if let periapsisKilometers = try? values.decodeIfPresent(Double.self, forKey: .periapsisKilometers) {
            periapsis = .init(value: periapsisKilometers, unit: .kilometers)
        }

        if let apoapsisKilometers = try? values.decodeIfPresent(Double.self, forKey: .apoapsisKilometers) {
            apoapsis = .init(value: apoapsisKilometers, unit: .kilometers)
        }

        if let inclinationDegrees = try? values.decodeIfPresent(Double.self, forKey: .inclinationDegrees) {
            inclination = .init(value: inclinationDegrees, unit: .degrees)
        }

        if let periodMinutes = try? values.decodeIfPresent(Double.self, forKey: .periodMinutes) {
            period = .init(value: periodMinutes, unit: .minutes)
        }

        lifespanYears = try? values.decodeIfPresent(Double.self, forKey: .lifespanYears)
        epoch = try? values.decodeIfPresent(Date.self, forKey: .epoch)
        meanMotion = try? values.decodeIfPresent(Double.self, forKey: .meanMotion)

        if let raanDegrees = try? values.decodeIfPresent(Double.self, forKey: .raanDegrees) {
            raan = .init(value: raanDegrees, unit: .degrees)
        }

        if let argumentOfPericenterDegrees = try? values.decodeIfPresent(Double.self, forKey: .argumentOfPericenterDegrees) {
            argumentOfPericenter = .init(value: argumentOfPericenterDegrees, unit: .degrees)
        }

        if let meanAnomalyDegrees = try? values.decodeIfPresent(Double.self, forKey: .meanAnomalyDegrees) {
            meanAnomaly = .init(value: meanAnomalyDegrees, unit: .degrees)
        }

        dragon = try? values.decodeIfPresent(Dragon.self, forKey: .dragon)
        stringID = try values.decode(String.self, forKey: .stringID)
    }
}

extension Payload.Dragon: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        capsuleID = try? values.decodeIfPresent(String.self, forKey: .capsuleID)

        if let massReturnedKilograms = try? values.decodeIfPresent(Double.self, forKey: .massReturnedKilograms) {
            massReturned = .init(value: massReturnedKilograms, unit: .kilograms)
        }

        if let flightTimeSeconds = try? values.decodeIfPresent(Double.self, forKey: .flightTimeSeconds) {
            flightTime = .init(value: flightTimeSeconds, unit: .seconds)
        }

        manifest = try? values.decodeIfPresent(URL.self, forKey: .manifest)
        waterLanding = try? values.decodeIfPresent(Bool.self, forKey: .waterLanding)
        landLanding = try? values.decodeIfPresent(Bool.self, forKey: .landLanding)
    }
}
