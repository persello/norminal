//
//  ShipLocationSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import MapKit
import SwiftUI

struct ShipLocationSection: View {
    @EnvironmentObject var ship: Ship
    @State private var region: MKCoordinateRegion?
    @State private var loaded: Bool = false

    var body: some View {
        if let location = ship.location {
            Section(header: Text("Location")) {
                if !loaded {
                    ProgressView()
                        .onAppear {
                            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                            loaded = true
                        }
                } else {
                    Map(coordinateRegion: Binding($region)!, annotationItems: [ship]) { item in
                        MapMarker(coordinate: item.location!.coordinate)
                    }
                    .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                    .aspectRatio(0.618 * 2, contentMode: .fill)
                }

                if let course = ship.course {
                    InformationRow(label: "Course", value: UsefulFormatters.measurementFormatter.string(from: course), image: {
                        Image(systemName: "location.north.line")
                            .rotationEffect(Angle(degrees: course.converted(to: .degrees).value))
                    })
                }

                if let speed = ship.speed {
                    InformationRow(label: "Speed",
                                   value: UsefulFormatters.measurementFormatter.string(from: speed.converted(to: .knots)),
                                   imageName: "gauge")
                }
            }
        }
    }
}

struct ShipLocationSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ShipLocationSection()
        }
        .environmentObject(FakeData.shared.ocisly!)
        .listStyle(InsetGroupedListStyle())
    }
}
