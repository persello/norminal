//
//  RocketSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 13/05/21.
//

import SwiftUI
import Telescope

struct RocketSheet: View {
    
    public init(launch: Launch) {
        self.launch = launch
        self.rocket = launch.rocket
    }
    
    public init(rocket: Rocket) {
        self.rocket = rocket
    }
    
    var launch: Launch?
    var rocket: Rocket?

    var body: some View {
        List {
            if let cores = launch?.cores {
                RocketCoresSection(cores: cores, upcoming: launch?.upcoming ?? false)
            }

            if let fairings = launch?.fairings,
               fairings.recoveryAttempt != nil {
                RocketFairingsSection(fairings: fairings)
            }

            if let rocket = rocket {
                Group {
                    RocketModelSection(rocket: rocket)

                    RocketPhysicalSpecificationsSection(rocket: rocket)

                    RocketPayloadWeightsSection(rocket: rocket)

                    if let firstStage = rocket.firstStage {
                        RocketFirstStageSection(firstStage: firstStage)
                    }
                    
                    if let secondStage = rocket.secondStage {
                        RocketSecondStageSection(secondStage: secondStage)
                    }

                    if let engines = rocket.engines {
                        RocketEnginesSection(engines: engines)
                    }
                }
                .environmentObject(rocket)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch?.rocket?.name ?? "Rocket"))
    }
}

struct RocketSheet_Previews: PreviewProvider {
    static var previews: some View {
        RocketSheet(rocket: FakeData.shared.falcon9!)
    }
}
