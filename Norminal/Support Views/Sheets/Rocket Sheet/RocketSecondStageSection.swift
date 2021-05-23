//
//  RocketSecondStageSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketSecondStageSection: View {
    var secondStage: Rocket.SecondStage

    var body: some View {
        Section(header: Text("Second stage")) {
            if let reusable = secondStage.reusable {
                InformationRow(label: "Reusable", value: reusable ? "Yes" : "No", imageName: "arrow.3.trianglepath")
            }

            if let engines = secondStage.engines {
                InformationRow(label: "Engines", value: "\(engines)", imageName: "flame")
            }

            if let fuelAmount = secondStage.fuelAmount {
                InformationRow(label: "Fuel amount", value: UsefulFormatters.measurementFormatter.string(from: fuelAmount), imageName: "gauge")
            }

            if let burnTime = secondStage.burnTime {
                InformationRow(label: "Burn time", value: "\(burnTime.converted(to: .seconds))", imageName: "stopwatch")
            }

            if let thrust = secondStage.thrust {
                InformationRow(label: "Thrust", value: "\(thrust)", imageName: "chevron.up")
            }
        }
    }
}

struct RocketSecondStageSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketSecondStageSection(secondStage: FakeData.shared.nrol108!.rocket!.secondStage!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
