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
    var onDidLoad: (() -> Void)?
    public var launches = [Launch]()
    public var loading = true {
        didSet {
            if let fLoad = onDidLoad {
                // Falling edge
                if(loading == false) {
                    fLoad()
                }
            }
        }
    }
    
    static var shared = SpaceXData()
    
    /// Creates a new instance of `SpaceXData`.
    init() {
        reloadLaunches()
    }
    
    
    /// Refreshes all data contained in this class.
    /// - Parameter sampleLaunchesSource: Set this parameter to the name of the file you want to use for sample data. Leave empty for real data.
    func reloadLaunches() {
        // Reset loading status
        DispatchQueue.main.async {
            self.loading = true
        }
        
        
        os_log("Getting data from web API.", log: .spaceXData, type: .info)
        fetchFromAPI()
        
    }
    
    private func decodeLaunches(_ data: Data?) throws -> [Launch]? {
        if let d = data {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.iso8601Full)
            let decodedLists = try decoder.decode([Launch].self, from: d)
            os_log("Launch decoder decoded %d launches from %d bytes of data.", log: .spaceXData, type: .info, decodedLists.count, d.count)
            return decodedLists
        } else {
            os_log("Launch decoder couldn't decode any launch because it received no data.", log: .spaceXData, type: .error)
            return nil
        }
    }
    
    private func fetchFromAPI() {
        
        let url = URL(string: "https://api.spacexdata.com/v4/launches")!
        os_log("Fetching data from %{public}@.", log: .spaceXData, type: .info, url.absoluteString)
        
        // Set up the session configuration
        let configuration = URLSessionConfiguration.ephemeral
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        // Create an URLSession with previous configuration
        let session = URLSession.init(configuration: configuration)
        
        // Get data
        session.dataTask(with: url) { (data, response, err) in
            do {
                
                if let e = err {
                    throw e
                }
                
                os_log("Data fetched successfully, starting decoder.", log: .spaceXData, type: .info)
                
                // Decode received JSON
                let decoded = try self.decodeLaunches(data)!
                
                // Update variables
                DispatchQueue.main.async {
                    self.launches = decoded
                    
                    // Loading ends successfully
                    self.loading = false
                }
                
            } catch {
                os_log("Error while fetching SpaceX launch data: \"%@\".", log: .spaceXData, type: .error, String(describing: error))
                
                // Loading ends unsuccessfully
                DispatchQueue.main.async {
                    self.loading = false
                }
            }
        }.resume()
        
        // This actually happens before the content of the "do" block
        os_log("Starting URLSession for SpaceX data fetch.", log: .spaceXData, type: .info)
    }
}
