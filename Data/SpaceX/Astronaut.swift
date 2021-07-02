//
//  Astronaut.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/10/2020.
//

import Foundation
import os
import SwiftUI
import Telescope

// MARK: - Astronaut class

/// Represents an astronaut
final class Astronaut: Decodable, ObservableObject, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/crew")!

    /// Name and surname of the astronaut
    public var name: String

    /// Name of the agency
    public var agency: String

    /// URL to a picture of the astronaut
    public var image: URL?

    /// Wikipedia article URL
    public var wikipedia: URL?

    /// List of launch IDs
    public var launchIDs: [String]?

    /// Whether this astronaut is active or not
    public var status: String

    /// Astronaut ID
    public var stringID: String

    private var cachedImage: UIImage?
    private static var cropper = FaceCropper()

    enum CodingKeys: String, CodingKey {
        case name
        case agency
        case image
        case wikipedia
        case launchIDs = "launches"
        case status
        case stringID = "id"
    }
}

// MARK: - Utility methods

extension Astronaut {
    func getImage(_ completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let i = cachedImage {
            completion(.success(i))
            return
        }

        if let url = image {
            if let image = RemoteImage(imageURL: url)[".cropped"] {
                cachedImage = image
                completion(.success(image))
            } else {
                try? RemoteImage(imageURL: url).image(completion: { image in
                    if let rawImage = image {
                        Astronaut.cropper.startCrop(image: rawImage, completionHandler: { cropResult in
                            switch cropResult {
                            case let .success(image):
                                self.cachedImage = image
                                RemoteImage(imageURL: url)[".cropped"] = image
                                completion(.success(image))
                            case let .failure(error):
                                completion(.failure(error))
                            }
                        })
                    }
                })
            }
        }
    }

    /// Returns the initials of the astronaut
    func getInitials() -> String {
        let components = name.components(separatedBy: " ")
        return "\((components.first?.first)!)\((components.last?.first)!)"
    }

    /// Returns the launches in which this astronaut participated
    func getLaunches(_ completion: @escaping ([Launch]?) -> Void) {
        Launch.loadFromArrayOfIdentifiers(ids: launchIDs) { result in
            switch result {
            case .failure:
                completion(nil)
            case let .success(launches):
                completion(launches)
            }
        }
    }
}

// MARK: - Protocol extension

extension Astronaut: Identifiable {
    var id: UUID { return UUID(stringWithoutDashes: stringID)! }
}
