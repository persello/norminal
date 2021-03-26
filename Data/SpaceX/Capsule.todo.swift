//
//  Capsule.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class Capsule: ObservableObject, Decodable {
    
    enum Status: String {
        case unknown, active, retired, destroyed
    }
    
    public var serial: String
    
    public var status: Status
    
    public var type: String
    
    public var dragon: String?
    
    
    
}
