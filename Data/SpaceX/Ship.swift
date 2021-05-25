//
//  Ship.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import CoreLocation
import Foundation

class Ship: ObservableObject, Decodable {
    public var name: String
    public var legacyID: String?
    public var model: String?
    public var type: String?
    public var roles: [String]?
    public var active: Bool
    public var imo: Int?
    public var mmsi: Int?
    public var mass: Measurement<UnitMass>?
    public var constructionYear: Int?
    public var homePort: String?
    public var status: String?
    public var speed: Measurement<UnitSpeed>?
    public var course: Measurement<UnitAngle>?
    public var location: CLLocation?
    public var link: URL?
    public var image: URL?
    private var launchIDs: [String]?
    public var launches: [Launch]? {
        launchIDs?.compactMap({ id in
            SpaceXData.shared.launches.first(where: { launch in
                launch.stringID == id
            })
        })
    }

    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case name
        case legacyID = "legacy_id"
        case model, type, roles, active, imo, mmsi
        case massKilograms = "mass_kg"
        case constructionYear = "year_built"
        case homePort = "home_port"
        case status
        case speedKnots = "speed_kn"
        case courseDegrees = "course_deg"
        case latitude, longitude
        case link, image
        case launchIDs = "launches"
        case stringID = "id"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        name = try values.decode(String.self, forKey: .name)
        legacyID = try? values.decodeIfPresent(String.self, forKey: .legacyID)
        model = try? values.decodeIfPresent(String.self, forKey: .model)
        type = try? values.decodeIfPresent(String.self, forKey: .type)
        roles = try? values.decodeIfPresent([String].self, forKey: .roles)
        active = try values.decode(Bool.self, forKey: .active)
        imo = try? values.decodeIfPresent(Int.self, forKey: .imo)
        mmsi = try? values.decodeIfPresent(Int.self, forKey: .mmsi)

        if let massKilograms = try? values.decodeIfPresent(Double.self, forKey: .massKilograms) {
            mass = .init(value: massKilograms, unit: .kilograms)
        }

        constructionYear = try? values.decodeIfPresent(Int.self, forKey: .constructionYear)
        homePort = try? values.decodeIfPresent(String.self, forKey: .homePort)
        status = try? values.decodeIfPresent(String.self, forKey: .status)

        if let speedKnots = try? values.decodeIfPresent(Double.self, forKey: .speedKnots) {
            speed = .init(value: speedKnots, unit: .knots)
        }

        if let courseDegrees = try? values.decodeIfPresent(Double.self, forKey: .courseDegrees) {
            course = .init(value: courseDegrees, unit: .degrees)
        }

        if let latitude = try? values.decodeIfPresent(Double.self, forKey: .latitude),
           let longitude = try? values.decodeIfPresent(Double.self, forKey: .longitude) {
            location = .init(latitude: latitude, longitude: longitude)
        }

        link = try? values.decodeIfPresent(URL.self, forKey: .link)
        image = try? values.decodeIfPresent(URL.self, forKey: .image)
        launchIDs = try? values.decodeIfPresent([String].self, forKey: .launchIDs)
        stringID = try values.decode(String.self, forKey: .stringID)
    }
}

extension Ship: Identifiable {
    var id: String { return stringID }
}
