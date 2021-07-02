//
//  CompanyInfo.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

final class CompanyInfo: Decodable, ObservableObject, Fetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/company")!

    struct Headquarters: Decodable, CustomStringConvertible {
        public var address: String?

        public var city: String?

        public var state: String?
        
        var description: String {
            return "\(address ?? "Unknown address"), \(city ?? "Unknown city") (\(state ?? "Unknown state"))"
        }
    }

    struct Links: Decodable {
        public var website: URL?

        public var flickr: URL?

        public var twitter: URL?

        public var elonTwitter: URL?

        enum CodingKeys: String, CodingKey {
            case website, flickr, twitter
            case elonTwitter = "elon_twitter"
        }
    }

    public var name: String?

    public var founder: String?

    public var foundationYear: Int?

    public var employees: Int?

    public var vehicles: Int?

    public var launchSites: Int?

    public var testSites: Int?

    public var ceo: String?

    public var cto: String?

    public var coo: String?

    public var propulsionCTO: String?

    public var valuation: Int?

    public var headquarters: Headquarters?

    public var links: Links?

    public var summary: String?
    
    public var stringID = "SpaceX"

    enum CodingKeys: String, CodingKey {
        case name, founder
        case foundationYear = "founded"
        case employees, vehicles
        case launchSites = "launch_sites"
        case testSites = "test_sites"
        case ceo, cto, coo
        case propulsionCTO = "cto_propulsion"
        case valuation, headquarters, links, summary
    }
}
