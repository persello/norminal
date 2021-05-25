//
//  FullscreenMapView.swift
//  Norminal
//
//  Created by Riccardo Persello on 21/05/21.
//

import BottomSheet
import MapKit
import SatelliteKit
import SwiftUI
import VisualEffects

struct FullscreenMapView: View {
    var satellites: [Satellite]
    @State private var selectedSatellite: Satellite? = nil
    @State private var sheetPosition: BottomSheetPosition = .middle
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(.world)
    @Binding var presented: Bool

    @State private var altitude: Measurement<UnitLength>?
    @State private var speed: Measurement<UnitSpeed>?
    @State private var course: Measurement<UnitAngle>?

    let satelliteStatsTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .topTrailing) {
            OrbitMap(satellites: satellites,
                     selectedSatellite: $selectedSatellite,
                     region: $region)
                .ignoresSafeArea()
                .bottomSheet(bottomSheetPosition: $sheetPosition, resizeable: true,
                             headerContent: {
                                 HStack(alignment: .firstTextBaseline) {
                                     Text(selectedSatellite?.commonName ?? "Payloads")
                                         .font(.title)
                                         .bold()
                                         .padding(8)
                                         .padding(.bottom, 16)
                                     Spacer()
                                     Button(action: {
                                         withAnimation {
                                             region = MKCoordinateRegion(.world)
                                             selectedSatellite = nil
                                         }
                                     }, label: {
                                         Image(systemName: "globe")
                                             .font(.title2)
                                     })
                                         .frame(width: 48, height: 48, alignment: .center)
                                         .contentShape(Rectangle())
                                 }
                             }) {
                    Group {
                        if let sat = selectedSatellite {
                            ScrollView {
                                VStack(alignment: .leading) {
                                    if let altitude = altitude {
                                        Text("Altitude: \(UsefulFormatters.measurementFormatter.string(from: altitude))")
                                    }

                                    if let speed = speed {
                                        Text("Speed: \(UsefulFormatters.measurementFormatter.string(from: speed))")
                                    }

                                    if let course = course {
                                        Text("Course: \(UsefulFormatters.measurementFormatter.string(from: course))")
                                    }
                                }
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .onReceive(satelliteStatsTimer, perform: { date in
                                    let location = sat.location(date: date)
                                    altitude = .init(value: location.altitude, unit: .meters)
                                    speed = .init(value: location.speed * 3600, unit: .kilometersPerHour)
                                    course = .init(value: location.course, unit: .degrees)
                                })
                            }
                        } else {
                            ScrollView {
                                ForEach(satellites) { satellite in
                                    Button(action: {
                                        withAnimation {
                                            selectedSatellite = satellite
                                            region = MKCoordinateRegion(
                                                center: satellite.location().coordinate,
                                                latitudinalMeters: 2000000,
                                                longitudinalMeters: 2000000
                                            )
                                            sheetPosition = .bottom
                                        }
                                    }) {
                                        HStack {
                                            let location = satellite.location()

                                            OrbitMap.DirectionalMarkerShape()
                                                .frame(width: 16, height: 16, alignment: .center)
                                                .background(
                                                    OrbitMap.DirectionalMarkerShape()
                                                        .frame(width: 24, height: 24, alignment: .center)
                                                        .foregroundColor(.white)
                                                        .shadow(radius: 4)
                                                )
                                                .padding(.horizontal, 8)
                                                .rotationEffect(Angle(degrees: location.course))

                                            VStack(alignment: .leading) {
                                                Text(satellite.commonName)
                                                    .foregroundColor(.primary)

                                                Text("Altitude: \(UsefulFormatters.plainNumberFormatter.string(from: NSNumber(value: location.altitude / 1000)) ?? "N/A") km")
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, 4)
                                            .padding(.leading, 8)
                                        }
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                }

            Button(action: { presented.toggle() }, label: {
                Text("\(Image(systemName: "xmark"))")
                    .bold()
                    .foregroundColor(.primary)
                    .background(
                        Circle()
                            .frame(width: 36, height: 36, alignment: .center)
                            .foregroundColor(.lightGray)
                    )
            })
                .padding(36)
                .contentShape(Circle())
        }
    }
}

struct FullscreenMapView_Previews: PreviewProvider {
    static var previews: some View {
        FullscreenMapView(satellites: FakeData.shared.bunchOfStarlinks!.filter({
            $0.spaceTrack?.decayed ?? false == false
        }).compactMap({
            if let tle = $0.spaceTrack?.tle {
                return Satellite(withTLE: tle)
            }
            return nil
        }),
        presented: .constant(true))
    }
}
