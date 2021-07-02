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
    
    @State var rockets: [Rocket]?
    @State var launches: [Launch]?

    var body: some View {
        List {
            LaunchpadDetailsSection()

            if let rockets = rockets,
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

            if let launches = launches,
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
        .onAppear {
            launchpad.getLaunches { launches in
                self.launches = launches
            }
            
            launchpad.getRockets { rockets in
                self.rockets = rockets
            }
        }
    }
}

struct LaunchpadSheet_Previews: PreviewProvider {
    static var previews: some View {
        RootSheet(modalShown: .constant(true)) { LaunchpadSheet(launchpad: FakeData.shared.slc40!) }
    }
}
