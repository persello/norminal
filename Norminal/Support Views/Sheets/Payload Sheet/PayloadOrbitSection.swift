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
    public init(tle: [TLE], payload: Payload? = nil) {
        self.tle = tle
        satellites = tle.compactMap({ tle in
            Satellite(withTLE: tle)
        })

        self.payload = payload

        if let center = satellites?.first?.location().coordinate {
            region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40))
        }
    }

    var tle: [TLE]
    var satellites: [Satellite]?
    var payload: Payload?
    @State var fullscreenMapPresented = false
    @State var region: MKCoordinateRegion = MKCoordinateRegion(.world)

    var body: some View {
        Section(header: Text("Orbit")) {
            if let satellites = satellites,
               satellites.count > 0 {
                OrbitMap(satellites: satellites, selectedSatellite: .constant(nil), region: $region)
                    .aspectRatio(1.618, contentMode: .fit)
                    .padding(.horizontal, -20)
                    .padding(.vertical, -6)
                Button(action: { fullscreenMapPresented.toggle() }) {
                    InformationRow(label: "View full map", imageName: "map")
                }
                .fullScreenCover(isPresented: $fullscreenMapPresented, content: {
                    FullscreenMapView(satellites: satellites,
                                      presented: $fullscreenMapPresented)
                })
            }

            if let payload = payload {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(payload.orbit ?? "Orbit")
                            .font(.largeTitle)
                            .bold()

                        if let regime = payload.regime {
                            Text("(\(regime) regime)")
                                .foregroundColor(.lightGray)
                                .bold()
                        }
                    }

                    if let referenceSystem = payload.referenceSystem {
                        Text(referenceSystem.capitalizingFirstLetter())
                            .foregroundColor(.gray)
                            .bold()
                    }
                }
                .padding(.top, 4)

                if let semiMajorAxis = payload.semiMajorAxis {
                    InformationRow(label: "Semimajor axis",
                                   value: UsefulFormatters.measurementFormatter.string(from: semiMajorAxis),
                                   imageName: "arrow.left.and.right")
                }

                if let eccentricity = payload.eccentricity {
                    InformationRow(label: "Eccentricity",
                                   value: UsefulFormatters.nDecimalsNumberFormatter(3).string(from: NSNumber(value: eccentricity)),
                                   imageName: "oval")
                }

                if let periapsis = payload.periapsis {
                    InformationRow(label: "Periapsis",
                                   value: UsefulFormatters.measurementFormatter.string(from: periapsis),
                                   imageName: "arrow.right.to.line")
                }

                if let apoapsis = payload.apoapsis {
                    InformationRow(label: "Apoapsis",
                                   value: UsefulFormatters.measurementFormatter.string(from: apoapsis),
                                   imageName: "arrow.right.to.line.alt")
                }

                if let inclination = payload.inclination {
                    InformationRow(label: "Inclination",
                                   value: UsefulFormatters.measurementFormatter.string(from: inclination),
                                   imageName: "line.diagonal")
                }

                if let period = payload.period {
                    InformationRow(label: "Period",
                                   value: UsefulFormatters.measurementFormatter.string(from: period),
                                   imageName: "stopwatch")
                }

                if let lifespan = payload.lifespanYears {
                    InformationRow(label: "Lifespan",
                                   value: "\(lifespan) years",
                                   imageName: "calendar")
                }
            }
        }
    }
}

struct PayloadOrbitSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadOrbitSection(tle: FakeData.shared.bunchOfStarlinks!.filter({ $0.spaceTrack?.decayed ?? false == false }).compactMap({ $0.spaceTrack?.tle }), payload: FakeData.shared.crew2Payload!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
