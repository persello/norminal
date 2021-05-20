//
//  PayloadOrbitSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI
import SatelliteKit

struct PayloadOrbitSection: View {
    
    public init(tle: [TLE]) {
        self.tle = tle
        self.satellites = tle.compactMap({tle in
            return Satellite(withTLE: tle)
        })
    }
    
    var tle: [TLE]
    var satellites: [Satellite]
    
    var body: some View {
        Section(header: Text("Orbit")) {
            OrbitMap(satellites: satellites, selectedSatellite: .constant(nil))
        }
    }
}

struct PayloadOrbitSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadOrbitSection(tle: [(FakeData.shared.firstStarlink!.spaceTrack?.tle!)!])
        }
        .listStyle(InsetGroupedListStyle())
    }
}
