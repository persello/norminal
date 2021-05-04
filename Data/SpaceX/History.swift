//
//  History.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

class HistoryEntry: ObservableObject, Decodable {
    struct Links: Decodable {
        public var article: URL?
    }

    public var title: String?
    public var date: Date?
    public var details: String?
    public var links: Links?

    enum CodingKeys: String, CodingKey {
        case title
        case date = "event_date_utc"
        case details, links
    }
}
