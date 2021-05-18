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

    var intrinsicStarlink: Starlink? {
        return SpaceXData.shared.starlinks.first(where: { starlink in
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
        VStack {
            Text(payload.name ?? "")
            Text(intrinsicStarlink?.version ?? "NO STARLINK")
            Text(intrinsicCapsule?.serial ?? "NO CAPSULE")
            Text(intrinsicDragon?.name ?? "NO DRAGON")
            Text(intrinsicRoadster?.name ?? "NO ROADSTER")
        }
    }
}

struct SinglePayloadSheet_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayloadSheet(payload: FakeData.shared.starlink22Payload!)
    }
}
