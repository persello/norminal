//
//  Filter.swift
//  Norminal for Mac
//
//  Created by Riccardo Persello on 28/03/21.
//

import Foundation
import OSLog
import SwiftUI

final class LaunchFilter: ObservableObject {
    var globalSettings = GlobalSettings.shared {
        willSet {
            objectWillChange.send()
        }
    }

    var text: String = "" {
        willSet {
            // A fix for the max CPU time
            if newValue != text {
                objectWillChange.send()
            }
        }
    }

    private func textLaunchFilter(_ launch: Launch) -> Bool {
        let nameMatch = launch.name.uppercased().contains(text.uppercased())

        var astronautNameMatch: Bool = false
        if let crew = launch.crew {
            for astronaut in crew {
                if astronaut.name.uppercased().contains(text.uppercased()) {
                    astronautNameMatch = true
                }
            }
        }

        let scopeMatch: Bool!
        switch globalSettings.launchFilterSelection {
        case .all:
            scopeMatch = true
        case .upcoming:
            scopeMatch = launch.upcoming
        case .past:
            scopeMatch = !launch.upcoming
        }

        return (nameMatch || astronautNameMatch) && scopeMatch
    }

    func filterLaunches(_ launches: [Launch]) -> [Launch]? {
        // Time filtering
        var filtered: [Launch]?

        switch globalSettings.launchFilterSelection {
        case .upcoming:
            // Upcoming
            filtered = launches.filter({ $0.upcoming })
        case .past:
            filtered = launches.filter({ !$0.upcoming }).reversed()
        default:
            filtered = launches.reversed()
        }

        // When we have a query do the text filtering
        if text.count > 0 {
            filtered = filtered?.filter(textLaunchFilter(_:))
        }

        // Then, let's re-order them
        if globalSettings.launchOrderSelection == .newest {
            filtered?.sort(by: {$0.dateAfterTolerance?.compare($1.dateAfterTolerance ?? .distantFuture) == .orderedDescending})
        } else if globalSettings.launchOrderSelection == .oldest {
            filtered?.sort(by: {$0.dateAfterTolerance?.compare($1.dateAfterTolerance ?? .distantFuture) == .orderedAscending})
        }
        
        return filtered
    }
}
