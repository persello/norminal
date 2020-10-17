//
//  SpaceXData.swift
//  norminal
//
//  Created by Riccardo Persello on 01/08/2020.
//  Copyright © 2020 Riccardo Persello. All rights reserved.
//

import Foundation
import Combine
import os

// MARK: Custom date formatter for extended ISO8601 support.
extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

// MARK: SpaceXData support class

/// Contains data obtained from the SpaceX API
final class SpaceXData {
    
    // Variables
//    var onDidLoad: (() -> Void)?
//    public var loading = true {
//        didSet {
//            if let fLoad = onDidLoad {
//                // Falling edge
//                if(loading == false) {
//                    fLoad()
//                }
//            }
//        }
//    }
    
    // SpaceX data sections
    public var launches = [Launch]()

    // Shared instance
    static var shared = SpaceXData()
    
    /// Creates a new instance of `SpaceXData`.
    init() {
    }
}
