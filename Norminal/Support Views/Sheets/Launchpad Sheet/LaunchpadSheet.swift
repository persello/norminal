//
//  LaunchpadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import MapKit
import SwiftUI

struct LaunchpadSheet: View {
    var launchpad: Launchpad

    var body: some View {
        List {
            LaunchpadDetailsSection()

            if let rockets = launchpad.rockets,
               rockets.count > 0 {
                Section(header: Text("Supported rockets")) {
                    ForEach(rockets) { rocket in
                        NavigationLink(destination: RocketSheet(rocket: rocket)) {
                            Text(rocket.name ?? "Unknown rocket")
                        }
                    }
                }
            }

            LaunchpadMapSection()

            if let launches = launchpad.launches,
               launches.count > 0 {
                Section(header: Text("Launches")) {
                    ForEach(launches) { launch in
                        LaunchListTile(launch: launch, showDetails: false)
                    }
                }
            }
        }
        .environmentObject(launchpad)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launchpad.name))
    }
}

struct LaunchpadSheet_Previews: PreviewProvider {
    static var previews: some View {
        RootSheet(modalShown: .constant(true)) { LaunchpadSheet(launchpad: FakeData.shared.slc40!) }
    }
}
