//
//  Dragon.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Dragon: Decodable, ObservableObject {
    struct HeatShield {
        public var material: String
        public var size: Measurement<UnitLength>
        public var temperature: Measurement<UnitTemperature>?
        public var developmentPartner: String?

        enum CodingKeys: String, CodingKey {
            case material
            case sizeMeters = "size_meters"
            case tempDegrees = "temp_degrees"
            case developmentPartner = "dev_partner"
        }
    }

    struct Thruster {
        public var type: String
        public var amount: Int
        public var pods: Int
        public var fuel1: String
        public var fuel2: String
        public var isp: Int
        public var thrust: Measurement<UnitForce>

        enum CodingKeys: String, CodingKey {
            case type
            case amount
            case pods
            case fuel1 = "fuel_1"
            case fuel2 = "fuel_2"
            case isp
            case thrustStruct = "thrust"
        }
    }

    struct PressurizedCapsule {
        public var payloadVolume: Measurement<UnitVolume>

        enum CodingKeys: String, CodingKey {
            case payloadVolumeStruct = "payload_volume"
        }
    }

    struct Trunk {
        struct Cargo: Decodable {
            public var solarArray: Int?
            public var unpressurizedCargo: Bool?

            enum CodingKeys: String, CodingKey {
                case solarArray = "solar_array"
                case unpressurizedCargo = "unpressurized_cargo"
            }
        }

        public var volume: Measurement<UnitVolume>
        public var cargo: Cargo?

        enum CodingKeys: String, CodingKey {
            case volume = "trunk_volume"
            case cargo
        }
    }

    public var name: String
    public var type: String
    public var active: Bool
    public var crewCapacity: Int
    public var sidewallAngle: Measurement<UnitAngle>
    public var orbitDurationYears: Double
    public var dryMass: Measurement<UnitMass>
    public var firstFlight: Date?
    public var heatShield: HeatShield?
    public var thrusters: [Thruster]?
    public var launchPayloadMass: Measurement<UnitMass>?
    public var launchPayloadVolume: Measurement<UnitVolume>?
    public var returnPayloadMass: Measurement<UnitMass>?
    public var returnPayloadVolume: Measurement<UnitVolume>?
    public var pressurizedCapsule: PressurizedCapsule?
    public var trunk: Trunk?
    public var heightWithTrunk: Measurement<UnitLength>?
    public var diameter: Measurement<UnitLength>?
    public var flickrImages: [URL]?
    public var description: String?
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case name
        case type
        case active
        case crewCapacity = "crew_capacity"
        case sidewallAngleDegrees = "sidewall_angle_deg"
        case orbitDurationYears = "orbit_duration_yr"
        case dryMassKilograms = "dry_mass_kg"
        case firstFlight = "first_flight"
        case heatShield = "heat_shield"
        case thrusters
        case launchPayloadMassStruct = "launch_payload_mass"
        case launchPayloadVolumeStruct = "launch_payload_vol"
        case returnPayloadMassStruct = "return_payload_mass"
        case returnPayloadVolumeStruct = "return_payload_vol"
        case pressurizedCapsule = "pressurized_capsule"
        case trunk
        case heightWithTrunkStruct = "height_w_trunk"
        case diameter
        case flickrImages = "flickr_images"
        case description
        case stringID = "id"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        type = try values.decode(String.self, forKey: .type)
        active = try values.decode(Bool.self, forKey: .active)
        crewCapacity = try values.decode(Int.self, forKey: .crewCapacity)

        let sidewallAngleDegrees = try values.decode(Double.self, forKey: .sidewallAngleDegrees)
        sidewallAngle = Measurement<UnitAngle>(value: sidewallAngleDegrees, unit: .degrees)

        orbitDurationYears = try values.decode(Double.self, forKey: .orbitDurationYears)

        let dryMassKilograms = try values.decode(Double.self, forKey: .dryMassKilograms)
        dryMass = Measurement<UnitMass>(value: dryMassKilograms, unit: .kilograms)

        // Date is YYYY-MM-DD
        let firstFlightDateString = try? values.decodeIfPresent(String.self, forKey: .firstFlight)
        let formatter = DateFormatter.yyyyMMdd
        firstFlight = formatter.date(from: firstFlightDateString ?? "")

        heatShield = try? values.decodeIfPresent(HeatShield.self, forKey: .heatShield)
        thrusters = try? values.decodeIfPresent([Thruster].self, forKey: .thrusters)

        if let launchPayloadMassKilograms = try? values
            .nestedContainer(keyedBy: MassStructCodingKeys.self, forKey: .launchPayloadMassStruct)
            .decode(Double.self, forKey: .kg) {
            launchPayloadMass = Measurement<UnitMass>(value: launchPayloadMassKilograms, unit: .kilograms)
        }

        if let launchPayloadVolumeCubicMeters = try? values
            .nestedContainer(keyedBy: VolumeStructCodingKeys.self, forKey: .launchPayloadVolumeStruct)
            .decode(Double.self, forKey: .cubicMeters) {
            launchPayloadVolume = Measurement<UnitVolume>(value: launchPayloadVolumeCubicMeters, unit: .cubicMeters)
        }

        if let returnPayloadMassKilograms = try? values
            .nestedContainer(keyedBy: MassStructCodingKeys.self, forKey: .returnPayloadMassStruct)
            .decode(Double.self, forKey: .kg) {
            returnPayloadMass = Measurement<UnitMass>(value: returnPayloadMassKilograms, unit: .kilograms)
        }

        if let returnPayloadVolumeCubicMeters = try? values
            .nestedContainer(keyedBy: VolumeStructCodingKeys.self, forKey: .returnPayloadVolumeStruct)
            .decode(Double.self, forKey: .cubicMeters) {
            returnPayloadVolume = Measurement<UnitVolume>(value: returnPayloadVolumeCubicMeters, unit: .cubicMeters)
        }

        pressurizedCapsule = try? values.decodeIfPresent(PressurizedCapsule.self, forKey: .pressurizedCapsule)
        trunk = try? values.decodeIfPresent(Trunk.self, forKey: .trunk)

        if let heightWithTrunkMeters = try? values
            .nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .heightWithTrunkStruct)
            .decode(Double.self, forKey: .meters) {
            heightWithTrunk = Measurement<UnitLength>(value: heightWithTrunkMeters, unit: .meters)
        }

        if let diameterMeters = try? values
            .nestedContainer(keyedBy: LengthStructCodingKeys.self, forKey: .diameter)
            .decode(Double.self, forKey: .meters) {
            diameter = Measurement<UnitLength>(value: diameterMeters, unit: .meters)
        }

        flickrImages = try? values.decodeIfPresent([URL].self, forKey: .flickrImages)
        description = try? values.decodeIfPresent(String.self, forKey: .description)
        stringID = try! values.decode(String.self, forKey: .stringID)
    }
}

extension Dragon.HeatShield: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        material = try values.decode(String.self, forKey: .material)

        let s = try values.decode(Double.self, forKey: .sizeMeters)
        size = Measurement<UnitLength>(value: s, unit: .meters)

        if let t = try? values.decodeIfPresent(Double.self, forKey: .tempDegrees) {
            temperature = Measurement<UnitTemperature>(value: t, unit: .celsius)
        }

        developmentPartner = try? values.decodeIfPresent(String.self, forKey: .developmentPartner)
    }
}

extension Dragon.Thruster: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        type = try values.decode(String.self, forKey: .type)
        amount = try values.decode(Int.self, forKey: .amount)
        pods = try values.decode(Int.self, forKey: .pods)
        fuel1 = try values.decode(String.self, forKey: .fuel1)
        fuel2 = try values.decode(String.self, forKey: .fuel2)
        isp = try values.decode(Int.self, forKey: .isp)

        let thrustKiloNewton = try values
            .nestedContainer(keyedBy: ForceStructCodingKeys.self, forKey: .thrustStruct)
            .decode(Double.self, forKey: .kN)

        thrust = Measurement<UnitForce>(value: thrustKiloNewton, unit: .kiloNewton)
    }
}

extension Dragon.PressurizedCapsule: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let volumeCubicMeters = try values
            .nestedContainer(keyedBy: VolumeStructCodingKeys.self, forKey: .payloadVolumeStruct)
            .decode(Double.self, forKey: .cubicMeters)

        payloadVolume = Measurement<UnitVolume>(value: volumeCubicMeters, unit: .cubicMeters)
    }
}

extension Dragon.Trunk: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        let volumeCubicMeters = try values
            .nestedContainer(keyedBy: VolumeStructCodingKeys.self, forKey: .volume)
            .decode(Double.self, forKey: .cubicMeters)

        volume = Measurement<UnitVolume>(value: volumeCubicMeters, unit: .cubicMeters)

        cargo = try? values.decodeIfPresent(Cargo.self, forKey: .cargo)
    }
}
