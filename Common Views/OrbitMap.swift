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
    struct DirectionalMarkerShape: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()

            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.width / 2, startAngle: Angle(degrees: 225), endAngle: Angle(degrees: -45), clockwise: true)
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY - rect.height / 4))

            return path
        }
    }

    struct SatelliteMarker: Identifiable {
        internal init(location: CLLocation, satellite: Satellite, kind: Kind = .satellite) {
            self.location = location
            self.satellite = satellite
            self.kind = kind
        }

        enum Kind {
            case satellite
            case trackPoint(offset: Double)
        }

        let location: CLLocation
        let satellite: Satellite
        let kind: Kind
        let id = UUID()
    }

    var satellites: [Satellite]
    @Binding var selectedSatellite: Satellite?
    @Binding var region: MKCoordinateRegion
    @State private var satelliteMarkers: [SatelliteMarker] = []

    @State var cachedTrackPoints: (Satellite, [SatelliteMarker])? = nil

    var trackPoints: [SatelliteMarker]? {
        if let selected = selectedSatellite {
            if let cache = cachedTrackPoints,
               cache.0 == selectedSatellite {
                return cache.1
            }

            let result = stride(from: -90.0, to: 90.0, by: 0.1).compactMap({ (offset) -> SatelliteMarker? in
                SatelliteMarker(location: selected.location(date: Date().addingTimeInterval(60 * Double(offset))), satellite: selected, kind: .trackPoint(offset: offset))
            })

            cachedTrackPoints = (selected, result)
            return result
        }

        return nil
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: satelliteMarkers) { marker in
            MapAnnotation(coordinate: marker.location.coordinate) {
                switch marker.kind {
                case .satellite:
                    DirectionalMarkerShape()
                        .foregroundColor(.blue)
                        .frame(width: 10, height: 10, alignment: .center)
                        .background(
                            DirectionalMarkerShape()
                                .foregroundColor(.white)
                                .frame(width: 16, height: 16, alignment: .center)
                        )
                        .scaleEffect(marker.satellite == selectedSatellite ? 2 : 1)
                        .rotationEffect(Angle(degrees: marker.location.course))
                        .shadow(color: .black.opacity(0.4),
                                radius: 4,
                                x: -CGFloat(Double(marker.location.altitude) / 50000.0),
                                y: CGFloat(Double(marker.location.altitude) / 50000.0))
                case let .trackPoint(offset):
                    Circle()
                        .frame(width: 4, height: 4, alignment: .center)
                        .foregroundColor(.blue.opacity(1 - abs(offset / 40)))
                        .shadow(color: .blue, radius: 4, x: 0, y: 0)
                }
            }
        }
        .onReceive(timer) { date in
            if let points = trackPoints {
                satelliteMarkers = points
            } else {
                satelliteMarkers = []
            }

            satelliteMarkers.append(contentsOf: satellites.compactMap({
                SatelliteMarker(location: $0.location(date: date), satellite: $0)
            }))
        }
    }
}

struct OrbitMap_Previews: PreviewProvider {
    static var satellites: [Satellite] {
        return FakeData.shared.bunchOfStarlinks!
            .filter({ $0.spaceTrack?.decayed ?? false == false })
            .compactMap({
                if let tle = $0.spaceTrack?.tle {
                    return Satellite(withTLE: tle)
                }
                return nil
            })
    }

    static var previews: some View {
        OrbitMap(satellites: satellites, selectedSatellite: .constant(satellites.last), region: .constant(MKCoordinateRegion(.world)))
    }
}
