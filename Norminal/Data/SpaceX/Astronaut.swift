//
//  Astronaut.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/10/2020.
//

import Foundation
import SwiftUI
import Alamofire
import AlamofireImage
import os

/// Represents an astronaut
struct Astronaut: Decodable {
    
    /// Name and surname of the astronaut
    public var name: String
    
    /// Name of the agency
    public var agency: String
    
    /// URL to a picture of the astronaut
    public var image: URL?
    
    /// Wikipedia article URL
    public var wikipedia: URL?
    
    /// List of launch IDs
    public var launches: [String]?
    
    /// Whether this astronaut is active or not
    public var status: String
    
    /// Astronaut ID
    public var idstring: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case agency = "agency"
        case image = "image"
        case wikipedia = "wikipedia"
        case launches = "launches"
        case status = "status"
        case idstring = "id"
    }
    
    /// Returns the initials of the astronaut
    func getInitials() -> String {
        return self.name.components(separatedBy: " ").reduce("") {"\($0.first!)\($1.first!)"}
    }
    
    /// Returns the astronaut image in a closure
    func getImage(_ handler: @escaping (UIImage?)->Void) {
        if let url = self.image {
            AF.request(url, method: .get).responseImage { response in
                switch response.result {
                case .failure(let error):
                    os_log("Error while getting astronaut image: \"%@\".", log: .ui, type: .error, error.errorDescription!)
                    handler(nil)
                case .success(let data):
                    handler(data)
                }
            }
        }
        handler(nil)
    }
}

extension Astronaut: Identifiable {
    var id: UUID {return UUID(stringWithoutDashes: self.idstring)!}
}
