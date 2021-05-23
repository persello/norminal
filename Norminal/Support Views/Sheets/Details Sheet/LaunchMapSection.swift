//
//  LaunchMapSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import MapKit
import SwiftUI

struct LaunchMapSection: View {
    @EnvironmentObject var launch: Launch
    @State private var region: MKCoordinateRegion?
    @State var annotationItems: [PointOfInterest] = []
    @State var loading = true

    func findAnnotationItems() {
        var result: [PointOfInterest] = []

        if let ships = launch.ships {
            for ship in ships {
                switch ship.type?.lowercased() {
                case "barge":
                    result.append(PointOfInterest(coordinates: ship.location!.coordinate, kind: .droneship, name: ship.name, originalObject: ship))
                default:
                    result.append(PointOfInterest(coordinates: ship.location?.coordinate, kind: .ship, name: ship.name, originalObject: ship))
                }
            }
        }

        if let launchpad = launch.launchpad {
            result.append(PointOfInterest(coordinates: launchpad.location, kind: .launchpad, name: launchpad.name, originalObject: launchpad))
        }

        if let landpads = launch.landpads {
            for landpad in landpads.filter({ $0.1?.stringID != nil }) {
                let _landpad = landpad.1

                switch _landpad?.type {
                case .ASDS:
                    break
                // Do nothing: it's a ship!
//                    result.append(PointOfInterest(coordinates: _landpad?.location, kind: .droneship, name: _landpad?.name, originalObject: _landpad))
                case .RTLS,
                     .none:
                    result.append(PointOfInterest(coordinates: _landpad?.location, kind: .landpad, name: _landpad?.name, originalObject: _landpad))
                }
            }
        }

        annotationItems = result
    }

    func generateDestinationView(poi: PointOfInterest) -> AnyView? {
        switch poi.kind {
        case .launchpad:
            if let launchpad = poi.originalObject as? Launchpad {
                return AnyView(LaunchpadSheet(launchpad: launchpad))
            }

            return nil

        case .landpad:
            if let landpad = poi.originalObject as? Landpad {
                return AnyView(LandpadSheet(landpad: landpad))
            }

            return nil

        case .ship,
             .droneship:
            if let ship = poi.originalObject as? Ship {
                return AnyView(ShipSheet(ship: ship))
            }

            return nil
        }
    }

    var body: some View {
        if !loading {
            Section(header: Text("Points of interest")) {
                if annotationItems.count > 0 {
                    if region != nil {
                        Map(coordinateRegion: Binding($region)!, annotationItems: annotationItems.filter({ $0.coordinates != nil })) { item in
                            MapAnnotation(coordinate: item.coordinates!,
                                          anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                                item.getMarker().scaleEffect(0.5)
                            }
                        }
                        .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                        .aspectRatio(0.618 * 2, contentMode: .fill)
                    }

                    ForEach(annotationItems) { item in
                        NavigationLink(destination: generateDestinationView(poi: item)) {
                            PointOfInterestRow(poi: item, region: $region)
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Text("No points of interest available")
                            .font(.title2)
                        Text("Check back in a few days")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                }
            }
        } else {
            HStack {
                Spacer()
                ProgressView()
                    .onAppear {
                        withAnimation {
                            findAnnotationItems()

                            if let launchpadLocation = launch.launchpad?.location {
                                region = MKCoordinateRegion(center: launchpadLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                            }

                            loading = false
                        }
                    }
                Spacer()
            }
        }
    }
}

struct LaunchMapSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LaunchMapSection()
        }
        .listStyle(InsetGroupedListStyle())
        .environmentObject(FakeData.shared.crewDragon!)
        .previewLayout(.sizeThatFits)
    }
}
