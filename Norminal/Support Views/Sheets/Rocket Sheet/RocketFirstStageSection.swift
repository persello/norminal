//
//  RocketFirstStageSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketFirstStageSection: View {
    var firstStage: Rocket.FirstStage

    var body: some View {
        Section(header: Text("First stage")) {
            if let reusable = firstStage.reusable {
                InformationRow(label: "Reusable", value: reusable ? "Yes" : "No", imageName: "arrow.3.trianglepath")
            }

            if let engines = firstStage.engines {
                InformationRow(label: "Engines", value: "\(engines)", imageName: "flame")
            }

            if let fuelAmount = firstStage.fuelAmount {
                InformationRow(label: "Fuel amount", value: UsefulFormatters.measurementFormatter.string(from: fuelAmount), imageName: "gauge")
            }

            if let burnTime = firstStage.burnTime {
                InformationRow(label: "Burn time", value: "\(burnTime.converted(to: .seconds))", imageName: "stopwatch")
            }

            if let seaLevelThrust = firstStage.seaLevelThrust {
                InformationRow(label: "Sea level thrust", value: "\(seaLevelThrust)", imageName: "chevron.compact.up")
            }
            
            if let vacuumThrust = firstStage.vacuumThrust {
                InformationRow(label: "Vacuum thrust", value: "\(vacuumThrust)", imageName: "chevron.up")
            }
        }
    }
}

struct RocketFirstStageSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketFirstStageSection(firstStage: FakeData.shared.falcon9!.firstStage!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
