//
//  RocketSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 13/05/21.
//

import SwiftUI
import Telescope

struct RocketSheet: View {
    var launch: Launch

    var body: some View {
        List {
            if let cores = launch.cores {
                RocketCoresSection(cores: cores, upcoming: launch.upcoming)
            }

            if let fairings = launch.fairings {
                RocketFairingsSection(fairings: fairings)
            }

            if let rocket = launch.rocket {
                Group {
                    RocketModelSection(rocket: rocket)

                    RocketPhysicalSpecificationsSection(rocket: rocket)
                    
                    RocketPayloadWeightsSection(rocket: rocket)

                    Section(header: Text("Stages")) {
                    }

                    Section(header: Text("Engines")) {
                    }

                    // TODO: Images
                }
                .environmentObject(rocket)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch.rocket?.name ?? "Rocket"))
    }
}

struct RocketSheet_Previews: PreviewProvider {
    static var previews: some View {
        RocketSheet(launch: FakeData.shared.nrol108!)
    }
}
