//
//  DetailsSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 03/05/21.
//

import MapKit
import SwiftUI

struct LaunchDetailsSection: View {
    var launch: Launch

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .font(.title.bold())

                Text("Launch #\(launch.flightNumber) • \(launch.getNiceDate(usePrecision: true))")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if let sfDate = launch.staticFireDateUTC {
                    Text("Static fire on \(sfDate.localDescription)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                if let details = launch.details {
                    Divider().padding(.vertical, 8)

                    Text(details)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .serif))

                    Divider().padding(.vertical, 8)
                }

                if let success = launch.success {
                    if success {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                            Text("Successful mission")
                        }
                    } else {
                        HStack {
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                            Text("Failed mission")
                        }

                        Divider().padding(.vertical, 8)

                        if let failures = launch.failures {
                            ForEach(failures, id: \.self) { failure in
                                VStack(alignment: .leading) {
                                    Text(failure.reason?.capitalizingFirstLetter() ?? "Unknown reason")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)

                                    HStack {
                                        if let time = failure.time {
                                            Text("T\(time > 0 ? "+" : "")\(time) seconds")
                                        }
                                        if let altitude = failure.altitude {
                                            Text("(\(altitude) kilometers)")
                                        }
                                    }
                                    .foregroundColor(.gray)
                                }
                            }
                        }

                        Divider().padding(.vertical, 8)
                    }

                    if !launch.upcoming {
                        switch launch.coresToRecover {
                        case 0:
                            EmptyView()
                        case 1:
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "arrow.3.trianglepath")
                                    .foregroundColor(launch.coresRecovered > 0 ? .green : .red)
                                Text("\(launch.coresRecovered > 0 ? "S" : "Uns")uccessful core recovery")
                            }
                        default:
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "arrow.3.trianglepath")
                                    .foregroundColor(launch.coresRecovered == launch.coresToRecover ? .green : .red)
                                Text("\(launch.coresRecovered) out of \(launch.coresToRecover) cores recovered")
                            }
                        }

                        // Fairings
                        if launch.fairings?.recoveryAttempt ?? false {
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: (launch.fairings?.recovered ?? false) ? "checkmark.shield" : "xmark.shield")
                                    .foregroundColor((launch.fairings?.recovered ?? false) ? .green : .red)
                                Text("Fairings \((launch.fairings?.recovered ?? false) ? "" : "not")recovered")
                            }
                        }
                    }
                }
            }
            .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 0))
        }
    }
}

struct PointOfInterestRow: View {
    var poi: DetailsSheet.PointOfInterest
    @Binding var region: MKCoordinateRegion?

    var body: some View {
        HStack {
            poi.getMarker(shadowRadius: 0).scaleEffect(0.5)
                .padding(-20)
                .padding(.leading, -10)

            VStack(alignment: .leading) {
                Text(poi.name ?? "Unknown")
                Text(poi.getRolesString() ?? poi.kind.rawValue.capitalizingFirstLetter())
                    .font(.subheadline)
                    .foregroundColor(Color.gray)

                if (poi.kind == .droneship || poi.kind == .ship)
                    && poi.coordinates != nil {
                    Text("Last known location shown")
                        .font(.subheadline)
                        .foregroundColor(.lightGray)
                }
            }

            Spacer()

            if let coords = poi.coordinates {
                Button(action: {
                    withAnimation {
                        self.region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    }
                }, label: {
                    Text("\(Image(systemName: "location.circle"))")
                })
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.blue)
            } else {
                Image(systemName: "location.slash")
            }
        }
    }
}

struct DetailsSheet: View {
    struct PointOfInterest: Identifiable {
        enum Kind: String {
            case droneship
            case launchpad
            case landpad
            case ship
        }

        let id = UUID()
        let coordinates: CLLocationCoordinate2D?
        let kind: Kind
        let name: String?
        let originalObject: Any?

        init(coordinates: CLLocationCoordinate2D?, kind: Kind, name: String? = nil, originalObject: Any? = nil) {
            self.coordinates = coordinates
            self.kind = kind
            self.name = name
            self.originalObject = originalObject
        }

        func getMarker(shadowRadius: CGFloat = 10) -> some View {
            switch kind {
            case .droneship:
                return TextMapMarkerView(text: (originalObject as? Landpad)?.name ?? "⤵️", shadowRadius: shadowRadius)
            case .landpad:
                return TextMapMarkerView(text: "⤵️", shadowRadius: shadowRadius)
            case .launchpad:
                return TextMapMarkerView(text: "🚀", shadowRadius: shadowRadius)
            case .ship:
                return TextMapMarkerView(text: "🛥", shadowRadius: shadowRadius)
            }
        }

        func getRolesString() -> String? {
            if let ship = originalObject as? Ship {
                if let roles = ship.roles {
                    return ListFormatter.localizedString(byJoining: roles).capitalizingFirstLetter()
                }
            }
            return nil
        }
    }

    var launch: Launch
    @State private var region: MKCoordinateRegion?
    @State var annotationItems: [PointOfInterest] = []

    func findAnnotationItems() {
        var result: [PointOfInterest] = []

        if let ships = launch.ships {
            for ship in ships {
                switch ship.type?.lowercased() {
                case "barge":
                    // Do nothing: it's a landpad!
                    //                    result.append(InterestingPlace(
                    //                                    coordintates: ship.location!.coordinate, kind: .droneship, name: ship.name))
                    break
                default:
                    result.append(PointOfInterest(coordinates: ship.location?.coordinate, kind: .ship, name: ship.name, originalObject: ship))
                }
            }
        }

        if let launchpad = launch.launchpad {
            result.append(PointOfInterest(coordinates: launchpad.location, kind: .launchpad, name: launchpad.name, originalObject: launchpad))
        }

        if let landpads = launch.landpads {
            for landpad in landpads.filter({ $0.1?.idstring != nil }) {
                let _landpad = landpad.1

                switch _landpad?.type {
                case .ASDS:
                    result.append(PointOfInterest(coordinates: _landpad?.location, kind: .droneship, name: _landpad?.name, originalObject: _landpad))
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
            case .droneship:
                return nil
            case .launchpad:
                if let launchpad = poi.originalObject as? Launchpad {
                    return AnyView(LaunchpadSheet(launchpad: launchpad))
                }
                
                return nil
            case .landpad:
                return nil
            case .ship:
                return nil
        }
    }

    var body: some View {
        List {
            LaunchDetailsSection(launch: launch)

            if annotationItems.count > 0 {
                Section(header: Text("Points of interest")) {
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
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch.name))
        .onAppear {
            findAnnotationItems()

            if let launchpadLocation = launch.launchpad?.location {
                region = MKCoordinateRegion(center: launchpadLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
            }
        }
    }
}

struct DetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSheet(launch: FakeData.shared.nrol108!)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
