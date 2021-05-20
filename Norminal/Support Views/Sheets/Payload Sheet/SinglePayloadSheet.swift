//
//  SinglePayloadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct SinglePayloadSheet: View {
    var payload: Payload

    var intrinsicCapsule: Capsule? {
        return payload.dragon?.capsule
    }

    var intrinsicDragon: Dragon? {
        if let dragonID = intrinsicCapsule?.dragon {
            // Not supported now, but might be when API gets fixed
            return SpaceXData.shared.dragons.first(where: { dragon in
                dragon.stringID == dragonID
            })
        } else {
            // Type matching
            // Ex. "Dragon 1" Dragon name matches with both "Dragon 1.1" and "Dragon 1.0" capsule types.

            return SpaceXData.shared.dragons.first(where: { dragon in
                intrinsicCapsule?.type.starts(with: dragon.name) ?? false
            })
        }
    }

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
           payload.manufacturers?.contains("Tesla") ?? false {
            return SpaceXData.shared.roadster
        }

        return nil
    }

    var body: some View {
        List {
            PayloadSection(payload: payload)

            if let noradIDs = payload.noradIDs,
               noradIDs.count > 0 {
                PayloadNORADSection(ids: noradIDs)
            }

            
            // Choose the right TLE sources!
            // Check for decayed satellites!
//            PayloadOrbitSection(payload: payload)

            if let starlinks = intrinsicStarlinks {
//                Text("Starlink \(starlink.version ?? "")")
                PayloadOrbitSection(tle: starlinks.filter({$0.spaceTrack?.decayed ?? false == false}).compactMap({$0.spaceTrack?.tle}))
            }

            if let capsule = intrinsicCapsule {
                Text(capsule.serial)
            }

            if let dragon = intrinsicDragon {
                Text(dragon.name)
            }

            if let roadster = intrinsicRoadster {
                Text(roadster.name ?? "Roadster")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(payload.name ?? intrinsicCapsule?.serial ?? intrinsicRoadster?.name ?? "Payload")
    }
}

struct SinglePayloadSheet_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayloadSheet(payload: FakeData.shared.crew2Payload!)
    }
}
