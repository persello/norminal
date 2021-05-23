//
//  LaunchpadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import MapKit
import SwiftUI

struct LaunchpadDetailsSection: View {
    @EnvironmentObject var launchpad: Launchpad

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
            .padding(.init(top: 10, leading: 5, bottom: 12, trailing: 0))
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

struct LaunchpadDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LaunchpadDetailsSection()
        }
        .environmentObject(FakeData.shared.slc40!)
        .listStyle(InsetGroupedListStyle())
    }
}
