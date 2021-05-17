//
//  UnitForce.swift
//  Norminal
//
//  Created by Riccardo Persello on 25/03/21.
//

import Foundation

class UnitForce: Dimension {
    static let kiloNewton = UnitForce(symbol: "kN", converter: UnitConverterLinear(coefficient: 1000.0))
    static let newton = UnitForce(symbol: "N", converter: UnitConverterLinear(coefficient: 1.0))
    static let lbf = UnitForce(symbol: "lbf", converter: UnitConverterLinear(coefficient: 4.4482216152605))
    
    static let baseUnit = UnitForce.newton
}
