//
//  SinglePayloadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SatelliteKit
import SwiftUI

struct SinglePayloadSheet: View {
    var payload: Payload

    var intrinsicStarlinks: [Starlink]? {
        return SpaceXData.shared.starlinks.filter({ starlink in
            if let sl = starlink.launch,
               let pl = payload.launch {
                return sl == pl
            }

            return false
        })
    }

    var intrinsicRoadster: Roadster? {
        if payload.name?.lowercased().contains("roadster") ?? false,
           payload.manufacturers == ["Tesla"] {
            return SpaceXData.shared.roadster
        }

        return nil
    }

    var congregatedTLEs: [TLE] {
        var tles: [TLE] = []

        // Starlinks
        if let starlinks = intrinsicStarlinks {
            tles += starlinks.filter({ $0.spaceTrack?.decayed ?? false == false }).compactMap({ $0.spaceTrack?.tle })
        }

        // Payload
        // TODO: Review inclination issue!

        return tles
    }

    var body: some View {
        List {
            // Header
            PayloadSection(payload: payload)

            // NORAD
            if let noradIDs = payload.noradIDs,
               noradIDs.count > 0 {
                PayloadNORADSection(ids: noradIDs)
            }

            // Orbit
            if intrinsicRoadster == nil {
                PayloadOrbitSection(tle: congregatedTLEs, payload: payload)
            }

            // Starlink
            if let starlinks = intrinsicStarlinks,
               starlinks.count > 0 {
                PayloadStarlinkSection(starlinks: starlinks)
            }

            // Capsule
            if payload.dragon?.capsule != nil {
                PayloadCapsuleInstanceSections(payload: payload)
            }

            // Roadster
            if let roadster = intrinsicRoadster {
                PayloadRoadsterSection(roadster: roadster)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(payload.name ?? "Payload")
    }
}

struct SinglePayloadSheet_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayloadSheet(payload: FakeData.shared.starlink22Payload!)
    }
}
