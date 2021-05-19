//
//  OrbitMap.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/05/21.
//

import MapKit
import SatelliteKit
import SwiftUI

extension CLLocationCoordinate2D {
    func addingLongitude(_ longitude: Double) -> Self {
        var a = self
        a.longitude += longitude
        return a
    }
}

struct OrbitMap: View {
    struct TestMarker: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
    }

    @State var toggleOn: Bool = false
    @State var timeOffset: Double = 0
    @State var longitudeOffset: Double = 0

    var testMarkers: [TestMarker] {
        let starlinks = SpaceXData.shared.starlinks.filter({ $0.launch == FakeData.shared.starlink22Payload?.launch })

        return starlinks.compactMap({
            if let coord = $0.location?.coordinate {
                return TestMarker(coordinate: coord)
            }

            return nil
        })
    }

    var satellites: [Satellite] {
        let starlinks = SpaceXData.shared.starlinks.filter({ $0.launch == FakeData.shared.starlink22Payload?.launch })

        print("\(starlinks.count)")

        return starlinks.compactMap({
            print("BBB")
            if let tle = $0.spaceTrack?.tle {
                print("AAA")
                return Satellite(withTLE: tle)
            }
            return nil
        })
    }

    @State var mapRect: MKMapRect = .world

    var body: some View {
        VStack {
            Text("timeOffset: \(timeOffset), longitudeOffset: \(longitudeOffset)")
            
            Toggle(isOn: $toggleOn, label: {
                Text(toggleOn ? "TLE data" : "Precomputed data")
            })
            
            Slider(value: $timeOffset, in: -10...10)
            Slider(value: $longitudeOffset, in: -60...30)

            toggleOn ?
                AnyView(Map(mapRect: $mapRect, annotationItems: satellites) { item in
                    MapAnnotation(coordinate: item.coordinates().coordinate.addingLongitude(longitudeOffset)) {
                        Circle()
                            .frame(width: 12, height: 12, alignment: .center)
                    }
                })
                :
                AnyView(Map(mapRect: $mapRect, annotationItems: testMarkers) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        Circle()
                            .foregroundColor(.blue)
                            .frame(width: 12, height: 12, alignment: .center)
                    }
                })
        }
    }
}

struct OrbitMap_Previews: PreviewProvider {
    static func fakeSatellites() -> [Satellite] {
        return []
    }

    static var previews: some View {
        OrbitMap()
    }
}
