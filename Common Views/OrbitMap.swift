//
//  OrbitMap.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/05/21.
//

import MapKit
import SatelliteKit
import SwiftUI

struct OrbitMap: View {
    struct SatelliteMarker: Identifiable {
        public init(satellite: Satellite, location: CLLocation) {
            self.satellite = satellite
            self.location = location
        }

        var location: CLLocation
        let satellite: Satellite
        let id = UUID()
    }

    var satellites: [Satellite]
    @State private var satelliteMarkers: [SatelliteMarker] = []
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(.world)

    let timer = Timer.publish(every: 1.0 / 10, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: satelliteMarkers) { marker in
            MapAnnotation(coordinate: marker.location.coordinate) {
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 10, height: 10, alignment: .center)
                    .background(
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16, alignment: .center)
                            .shadow(radius: 4)
                    )
            }
        }
        .onReceive(timer) { date in
            satelliteMarkers = satellites.compactMap({
                SatelliteMarker(satellite: $0, location: $0.coordinates(date: date))
            })
        }
    }
}

struct OrbitMap_Previews: PreviewProvider {
    static var previews: some View {
        OrbitMap(satellites: FakeData.shared.bunchOfStarlinks!
            .filter({ $0.spaceTrack?.decayed ?? false == false })
            .compactMap({
                if let tle = $0.spaceTrack?.tle {
                    return Satellite(withTLE: tle)
                }
                return nil
            }))
    }
}
