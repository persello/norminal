//
//  Rocket.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/03/21.
//

import Foundation

// MARK: - Rocket class

/// Represents a rocket launchpad
final class Rocket: ObservableObject, Decodable, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/rockets")!

    // MARK: - Internal structs

    struct PayloadWeight {
        public var id: String?
        public var name: String?
        public var maximumMass: Measurement<UnitMass>?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case kg
            case lb
        }
    }

    struct FirstStage {
        public var reusable: Bool?

        public var engines: Int?

        public var fuelAmount: Measurement<UnitMass>?

        public var burnTime: Measurement<UnitDuration>?

        public var seaLevelThrust: Measurement<UnitForce>?

        public var vacuumThrust: Measurement<UnitForce>?

        enum CodingKeys: String, CodingKey {
            case seaLevelThrustStruct = "thrust_sea_level"
            case vacuumThrustStruct = "thrust_vacuum"
            case reusable
            case engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTime = "burn_time_sec"
        }
    }

    struct SecondStage {
        struct Payloads {
            struct CompositeFairing {
                public var height: Measurement<UnitLength>?

                public var diameter: Measurement<UnitLength>?

                enum CodingKeys: String, CodingKey {
                    case heightStruct = "height"
                    case diameterStruct = "diameter"
                }
            }

            public var option: String?

            public var compositeFairing: CompositeFairing?

            enum CodingKeys: String, CodingKey {
                case option = "option_1"
                case compositeFairing = "composite_fairing"
            }
        }

        public var reusable: Bool?

        public var engines: Int?

        public var fuelAmount: Measurement<UnitMass>?

        public var burnTime: Measurement<UnitDuration>?

        public var thrust: Measurement<UnitForce>?

        public var payloads: Payloads?

        enum CodingKeys: String, CodingKey {
            case thrustStruct = "thrust"
            case reusable
            case engines
            case fuelAmountTons = "fuel_amount_tons"
            case burnTime = "burn_time_sec"
            case payloads
        }
    }

    struct Engines {
        public var number: Int?

        public var type: String?

        public var version: String?

        public var layout: String?

        public var ispSeaLevel: Measurement<UnitDuration>?

        public var ispVacuum: Measurement<UnitDuration>?

        public var maxEngineLoss: Int?

        public var propellant1: String?

        public var propellant2: String?

        public var seaLevelThrust: Measurement<UnitForce>?

        public var vacuumThrust: Measurement<UnitForce>?

        public var thrustWeightRatio: Double?

        enum CodingKeys: String, CodingKey {
            case number
            case type
            case version
            case layout
            case ispStruct = "isp"
            case maxEngineLoss = "engine_loss_max"
            case propellant1 = "propellant_1"
            case propellant2 = "propellant_2"
            case seaLevelThrustStruct = "thrust_sea_level"
            case vacuumThrustStruct = "thrust_vacuum"
            case thrustToWeightRatio = "thrust_to_weight"
        }
    }

    // MARK: - Properties

    public var name: String?

    public var type: String?

    public var active: Bool?

    public var stages: Int?

    public var boosters: Int?

    public var costPerLaunch: Double?

    public var successRate: Double?

    public var firstFlight: Date?

    public var country: String?

    public var company: String?

    public var height: Measurement<UnitLength>?

    public var diameter: Measurement<UnitLength>?

    public var mass: Measurement<UnitMass>?

    public var payloadWeights: [PayloadWeight]?

    public var firstStage: FirstStage?

    public var secondStage: SecondStage?

    public var engines: Engines?

    public var landingLegsCount: Int?

    public var landingLegsMaterial: String?

    public var flickrImages: [URL]?

    public var wikipedia: URL?

    public var description: String?

    public var stringID: String

    // MARK: - Decoding

    enum CodingKeys: String, CodingKey {
        case name
        case type
        case active
        case stages
        case boosters
        case costPerLaunch = "cost_per_launch"
        case successRate = "success_rate_pct"
        case firstFlight = "first_flight"
        case country
        case company
        case heightStruct = "height"
        case diameterStruct = "diameter"
        case massStruct = "mass"
        case payloadWeights = "payload_weights"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegsStruct = "landing_legs"
        case flickrImages = "flickr_images"
        case wikipedia
        case description
        case stringID = "id"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try? values.decodeIfPresent(String.self, forKey: .name)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        active = try? values.decodeIfPresent(Bool.self, forKey: .active)
        stages = try? values.decodeIfPresent(Int.self, forKey: .stages)
        boosters = try? values.decodeIfPresent(Int.self, forKey: .boosters)
        costPerLaunch = try? values.decodeIfPresent(Double.self, forKey: .costPerLaunch)
        successRate = try? values.decodeIfPresent(Double.self, forKey: .successRate)

        // Date is YYYY-MM-DD
        let firstFlightDateString = try? values.decodeIfPresent(String.self, forKey: .firstFlight)
        let formatter = DateFormatter.yyyyMMdd
        firstFlight = formatter.date(from: firstFlightDateString ?? "")

        country = try? values.decodeIfPresent(String.self, forKey: .country)
        company = try? values.decodeIfPresent(String.self, forKey: .company)

        if let h = try? values.nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .heightStruct).decodeIfPresent(Double.self, forKey: .meters) {
            height = Measurement<UnitLength>(value: h, unit: .meters)
        }

        if let d = try? values.nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .diameterStruct).decodeIfPresent(Double.self, forKey: .meters) {
            diameter = Measurement<UnitLength>(value: d, unit: .meters)
        }

        if let m = try? values.nestedContainer(keyedBy: MassStructCodingKeys.self, forKey: .massStruct).decodeIfPresent(Double.self, forKey: .kg) {
            mass = Measurement<UnitMass>(value: m, unit: .kilograms)
        }

        payloadWeights = try? values.decodeIfPresent([PayloadWeight].self, forKey: .payloadWeights)
        firstStage = try? values.decodeIfPresent(FirstStage.self, forKey: .firstStage)
        secondStage = try? values.decodeIfPresent(SecondStage.self, forKey: .secondStage)
        engines = try? values.decodeIfPresent(Engines.self, forKey: .engines)

        if let ll = try? values.nestedContainer(keyedBy: LandingLegsCodingKeys.self, forKey: .landingLegsStruct) {
            landingLegsCount = try? ll.decodeIfPresent(Int.self, forKey: .number)
            landingLegsMaterial = try? ll.decodeIfPresent(String.self, forKey: .material)
        }

        flickrImages = try? values.decodeIfPresent([URL].self, forKey: .flickrImages)
        wikipedia = try? values.decodeIfPresent(URL.self, forKey: .wikipedia)
        description = try? values.decodeIfPresent(String.self, forKey: .description)

        // Must have an ID
        stringID = try values.decode(String.self, forKey: .stringID)
    }
}

// MARK: - Extensions

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension Rocket.PayloadWeight: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try? values.decodeIfPresent(String.self, forKey: .id)
        name = try? values.decodeIfPresent(String.self, forKey: .name)
        if let mm = try? values.decodeIfPresent(Double.self, forKey: .kg) {
            maximumMass = Measurement<UnitMass>(value: mm, unit: .kilograms)
        }
    }
}

extension Rocket.FirstStage: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        reusable = try? values.decodeIfPresent(Bool.self, forKey: .reusable)
        engines = try? values.decodeIfPresent(Int.self, forKey: .engines)
        if let fa = try? values.decodeIfPresent(Double.self, forKey: .fuelAmountTons) {
            fuelAmount = Measurement<UnitMass>(value: fa, unit: .metricTons)
        }

        if let bt = try? values.decodeIfPresent(Double.self, forKey: .burnTime) {
            burnTime = Measurement<UnitDuration>(value: bt, unit: .seconds)
        }

        if let slt = try? values.nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .seaLevelThrustStruct).decodeIfPresent(Double.self, forKey: .kN) {
            seaLevelThrust = Measurement<UnitForce>(value: slt, unit: .kiloNewton)
        }

        if let vt = try? values.nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .vacuumThrustStruct).decodeIfPresent(Double.self, forKey: .kN) {
            vacuumThrust = Measurement<UnitForce>(value: vt, unit: .kiloNewton)
        }
    }
}

extension Rocket.SecondStage: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        reusable = try? values.decodeIfPresent(Bool.self, forKey: .reusable)
        engines = try? values.decodeIfPresent(Int.self, forKey: .engines)
        if let fa = try? values.decodeIfPresent(Double.self, forKey: .fuelAmountTons) {
            fuelAmount = Measurement<UnitMass>(value: fa, unit: .metricTons)
        }

        if let bt = try? values.decodeIfPresent(Double.self, forKey: .burnTime) {
            burnTime = Measurement<UnitDuration>(value: bt, unit: .seconds)
        }

        if let t = try? values.nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .thrustStruct).decodeIfPresent(Double.self, forKey: .kN) {
            thrust = Measurement<UnitForce>(value: t, unit: .kiloNewton)
        }

        payloads = try? values.decodeIfPresent(Payloads.self, forKey: .payloads)
    }
}

extension Rocket.SecondStage.Payloads: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        option = try? values.decodeIfPresent(String.self, forKey: .option)
        compositeFairing = try? values.decodeIfPresent(CompositeFairing.self, forKey: .compositeFairing)
    }
}

extension Rocket.SecondStage.Payloads.CompositeFairing: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let h = try? values.nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .heightStruct).decodeIfPresent(Double.self, forKey: .meters) {
            height = Measurement<UnitLength>(value: h, unit: .meters)
        }

        if let d = try? values.nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .diameterStruct).decodeIfPresent(Double.self, forKey: .meters) {
            diameter = Measurement<UnitLength>(value: d, unit: .meters)
        }
    }
}

extension Rocket.Engines: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        number = try? values.decodeIfPresent(Int.self, forKey: .number)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        version = try? values.decodeIfPresent(String.self, forKey: .version)
        layout = try? values.decodeIfPresent(String.self, forKey: .layout)
        if let isp = try? values.nestedContainer(keyedBy: ISPStructCodingKeys.self, forKey: .ispStruct) {
            if let isl = try isp.decodeIfPresent(Double.self, forKey: .seaLevel) {
                ispSeaLevel = Measurement<UnitDuration>(value: isl, unit: .seconds)
            }

            if let isv = try isp.decodeIfPresent(Double.self, forKey: .vacuum) {
                ispVacuum = Measurement<UnitDuration>(value: isv, unit: .seconds)
            }
        }

        maxEngineLoss = try? values.decodeIfPresent(Int.self, forKey: .maxEngineLoss)
        propellant1 = try? values.decodeIfPresent(String.self, forKey: .propellant1)
        propellant2 = try? values.decodeIfPresent(String.self, forKey: .propellant2)

        if let slt = try? values.nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .seaLevelThrustStruct).decodeIfPresent(Double.self, forKey: .kN) {
            seaLevelThrust = Measurement<UnitForce>(value: slt, unit: .kiloNewton)
        }

        if let vt = try? values.nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .vacuumThrustStruct).decodeIfPresent(Double.self, forKey: .kN) {
            vacuumThrust = Measurement<UnitForce>(value: vt, unit: .kiloNewton)
        }

        thrustWeightRatio = try? values.decodeIfPresent(Double.self, forKey: .thrustToWeightRatio)
    }
}

extension Rocket {
    var stageCountDescription: String {
        var result: String!
        if let stages = stages {
            switch stages {
            case 1:
                result = "Single-stage"
            case 2:
                result = "Two-stage"
            default:
                result = "\(stages)-stage"
            }
        } else {
            result = "Unknown staging"
        }
       
        return result
    }
}

extension Rocket: Identifiable {
    var id: String { return stringID }
}

extension Rocket: Equatable {
    static func == (lhs: Rocket, rhs: Rocket) -> Bool {
        return lhs.id == rhs.id
    }
}
