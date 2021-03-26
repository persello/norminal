//
//  AdditionalCodingKeys.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

enum LengthStructCodingKeys: String, CodingKey {
    case meters = "meters"
    case feet = "feet"
}

enum MassStructCodingKeys: String, CodingKey {
    case kg = "kg"
    case lb = "lb"
}

enum ForceStructCodingKeys: String, CodingKey {
    case kN = "kN"
    case lbf = "lbf"
}

enum ISPStructCodingKeys: String, CodingKey {
    case seaLevel = "sea_level"
    case vacuum
}

enum LandingLegsCodingKeys: String, CodingKey {
    case number
    case material
}
