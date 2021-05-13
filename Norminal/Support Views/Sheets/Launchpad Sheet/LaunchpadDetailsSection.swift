//
//  LaunchpadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import MapKit
import SwiftUI

struct LaunchpadMapSection: View {
    var launchpad: Launchpad

    @State var region: MKCoordinateRegion?

    var body: some View {
        Section(header: Text("Map")) {
            VStack(alignment: .leading) {
                if region != nil {
                    Map(coordinateRegion: Binding($region)!, annotationItems: [launchpad]) { item in
                        MapPin(coordinate: item.location)
                    }
                    .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                    .aspectRatio(0.618 * 2, contentMode: .fill)
                }

                VStack(alignment: .leading) {
                    Text(launchpad.locality)
                        .font(.title.bold())
                    Text(launchpad.region)
                        .foregroundColor(.gray)
                }
                .padding(.init(top: 15, leading: 5, bottom: 15, trailing: 0))
                .onAppear {
                    region = MKCoordinateRegion(center: launchpad.location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
            }
        }
    }
}

struct LaunchpadDetailsSection: View {
    var launchpad: Launchpad

    @State private var forecast: WeatherAPIResponse.WeatherAPIForecastHour?
    @State private var forecastError: Bool = false

    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("Details")
                    .font(.title.bold())

                Text("\(launchpad.fullName) • \(launchpad.status.rawValue.capitalizingFirstLetter())")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                if let details = launchpad.details {
                    Divider().padding(.vertical, 8)

                    Text(details)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .serif))
                }

                if !forecastError {
                    Divider().padding(.vertical, 8)

                    if let forecast = forecast {
                        Label(
                            title: { Text(forecast.condition.text) },
                            icon: {
                                Image(systemName: forecast.getIcon() + ".fill")
                                    .renderingMode(.original)
                                    .shadow(radius: 1)
                            }
                        )
                    } else {
                        ProgressView()
                    }
                }

                Divider().padding(.vertical, 8)

                if launchpad.launchAttempts > 0 {
                    if launchpad.launchAttempts == launchpad.launchSuccesses {
                        Label(
                            title: { Text("All \(launchpad.launchAttempts) launches successful") },
                            icon: { Text("🚀") }
                        )
                    } else {
                        Label(
                            title: {
                                Text("\(launchpad.launchSuccesses) out of \(launchpad.launchAttempts) launches successful")
                            },
                            icon: { Text("🚀") }
                        )
                    }
                } else {
                    Label(
                        title: { Text("No launches from this launchpad yet") },
                        icon: { Image(systemName: "questionmark") }
                    )
                }
            }
            .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 0))
        }
        .onAppear {
            launchpad.getForecast(for: Date(), completion: { forecast in
                switch forecast {
                case let .success(forecast):
                    self.forecast = forecast
                    self.forecastError = false
                case .failure:
                    self.forecastError = false
                }
            })
        }
    }
}

struct LaunchpadSheet: View {
    var launchpad: Launchpad

    var body: some View {
        List {
            LaunchpadDetailsSection(launchpad: launchpad)
            LaunchpadMapSection(launchpad: launchpad)

            if let launches = launchpad.launches {
                Section(header: Text("Launches")) {
                    ForEach(launches) { launch in
                        NavigationLink(destination: LaunchDetailView(launch: launch)) {
                            LaunchListTile(launch: launch, showDetails: false)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launchpad.name))
    }
}

struct LaunchpadSheet_Previews: PreviewProvider {
    static var previews: some View {
        RootSheet(modalShown: .constant(true)) { LaunchpadSheet(launchpad: FakeData.shared.slc40!) }
    }
}
