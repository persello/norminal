//
//  DetailsSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 03/05/21.
//

import MapKit
import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

struct DetailsSheet: View {
    struct InterestingPlace: Identifiable {
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
        let roles: [String]?

        init(coordinates: CLLocationCoordinate2D?, kind: Kind, name: String? = nil, roles: [String]? = nil) {
            self.coordinates = coordinates
            self.kind = kind
            self.name = name
            self.roles = roles
        }

        func getMarker(shadowRadius: CGFloat = 10) -> some View {
            switch kind {
            case .droneship:
                return TextMapMarkerView(text: name ?? "⤵️", shadowRadius: shadowRadius)
            case .landpad:
                return TextMapMarkerView(text: "⤵️", shadowRadius: shadowRadius)
            case .launchpad:
                return TextMapMarkerView(text: "🚀", shadowRadius: shadowRadius)
            case .ship:
                return TextMapMarkerView(text: "🛥", shadowRadius: shadowRadius)
            }
        }

        func getRolesString() -> String? {
            if let roles = roles {
                return ListFormatter.localizedString(byJoining: roles).capitalizingFirstLetter()
            }
            return nil
        }
    }

    var launch: Launch
    @State private var region: MKCoordinateRegion?
    @Binding var modalShown: Bool

    @State var annotationItems: [InterestingPlace] = []

    func findAnnotationItems() {
        var result: [InterestingPlace] = []

        if let ships = launch.ships {
            for ship in ships {
                switch ship.type?.lowercased() {
                case "barge":
                    // Do nothing: it's a landpad!
                    //                    result.append(InterestingPlace(
                    //                                    coordintates: ship.location!.coordinate, kind: .droneship, name: ship.name))
                    break
                default:
                    result.append(InterestingPlace(coordinates: ship.location?.coordinate, kind: .ship, name: ship.name, roles: ship.roles))
                }
            }
        }

        if let launchpad = launch.launchpad {
            result.append(InterestingPlace(coordinates: launchpad.location, kind: .launchpad, name: launchpad.name))
        }

        if let landpads = launch.landpads {
            for landpad in landpads {
                let _landpad = landpad.1

                switch _landpad?.type {
                case .ASDS:
                    result.append(InterestingPlace(coordinates: _landpad?.location, kind: .droneship, name: _landpad?.name))
                case .RTLS,
                     .none:
                    result.append(InterestingPlace(coordinates: _landpad?.location, kind: .landpad, name: _landpad?.name))
                }
            }
        }

        annotationItems = result
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details")
                            .font(.title.bold())
                        Text(launch.details ?? "")
                            .multilineTextAlignment(.leading)
                            .font(.system(.body, design: .serif))
                    }
                    .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 0))
                }

                if annotationItems.count > 0 {
                    Section(header: Text("Points of interest")) {
                        if region != nil {
                            Map(coordinateRegion: Binding($region)!, annotationItems: annotationItems.filter({ $0.coordinates != nil })) { item in
                                MapAnnotation(coordinate: item.coordinates!, anchorPoint: CGPoint(x: 0.5, y: 0.5)) {
                                    item.getMarker().scaleEffect(0.5)
                                }
                            }
                            .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                            .aspectRatio(0.618 * 2, contentMode: .fill)
                        }

                        ForEach(annotationItems) { item in
                            NavigationLink(destination: EmptyView()) {
                                HStack {
                                    item.getMarker(shadowRadius: 0).scaleEffect(0.5)
                                        .padding(-20)
                                        .padding(.leading, -10)

                                    VStack(alignment: .leading) {
                                        Text(item.name ?? "Unknown")
                                        Text(item.getRolesString() ?? item.kind.rawValue.capitalizingFirstLetter())
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)

                                        if (item.kind == .droneship || item.kind == .ship)
                                            && item.coordinates != nil {
                                            Text("Current location shown")
                                                .font(.subheadline)
                                                .foregroundColor(.lightGray)
                                        }
                                    }

                                    Spacer()

                                    if let coords = item.coordinates {
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
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text(launch.name))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
            .onAppear {
//                SpaceXData.shared.loadAllData()

                findAnnotationItems()

                if let launchpadLocation = launch.launchpad?.location {
                    region = MKCoordinateRegion(center: launchpadLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                }
            }
        }
    }
}

struct DetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSheet(launch: FakeData.shared.crewDragon!, modalShown: .constant(true))
    }
}
