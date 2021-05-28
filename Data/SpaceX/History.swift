//
//  History.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/03/21.
//

import Foundation

final class HistoryEntry: ObservableObject, Decodable, ArrayFetchable {
    static var baseURL: URL = URL(string: "https://api.spacexdata.com/v4/history")!

    struct Links: Decodable {
        public var article: URL?
    }

    public var title: String?
    public var date: Date?
    public var details: String?
    public var links: Links?
    public var stringID: String

    enum CodingKeys: String, CodingKey {
        case title
        case date = "event_date_utc"
        case details, links
        case stringID = "id"
    }
}

extension HistoryEntry: Identifiable {
    var id: String {
        return stringID
    }
}
