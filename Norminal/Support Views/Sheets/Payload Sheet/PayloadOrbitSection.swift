//
//  PayloadOrbitSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import MapKit
import SatelliteKit
import SwiftUI

struct PayloadOrbitSection: View {
    public init(tle: [TLE]) {
        self.tle = tle
        satellites = tle.compactMap({ tle in
            Satellite(withTLE: tle)
        })
    }

    var tle: [TLE]
    var satellites: [Satellite]
    @State var fullscreenMapPresented = false

    var body: some View {
        Section(header: Text("Orbit")) {
            OrbitMap(satellites: satellites, selectedSatellite: .constant(nil), region: .constant(MKCoordinateRegion(.world)))
                .aspectRatio(1.618, contentMode: .fit)
                .padding(.horizontal, -20)
                .padding(.vertical, -6)
            Button(action: {fullscreenMapPresented.toggle()}) {
                InformationRow(label: "View full map", imageName: "map")
            }
            .fullScreenCover(isPresented: $fullscreenMapPresented, content: {
                FullscreenMapView(satellites: satellites,
                                  presented: $fullscreenMapPresented)
            })
        }
    }
}

struct PayloadOrbitSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadOrbitSection(tle: FakeData.shared.bunchOfStarlinks!.filter({ $0.spaceTrack?.decayed ?? false == false }).compactMap({ $0.spaceTrack?.tle }))
        }
        .listStyle(InsetGroupedListStyle())
    }
}
