//
//  RocketEnginesSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketEnginesSection: View {
    var engines: Rocket.Engines

    var body: some View {
        Section(header: Text("Engines")) {
            VStack(alignment: .leading) {
                Text((engines.type ?? "Unknown engine").capitalizingFirstLetter() + " " + (engines.version ?? ""))
                    .font(.title)
                    .bold()

                Text("\(engines.layout ?? "unknown") layout".uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)
            }
            .padding(.vertical, 4)

            if let number = engines.number {
                InformationRow(label: "Count", value: "\(number)", imageName: "number")
            }

            if let seaLevelISP = engines.ispSeaLevel {
                InformationRow(label: "Sea level ISP", value: "\(seaLevelISP)", imageName: "stopwatch")
            }

            if let vacuumISP = engines.ispVacuum {
                InformationRow(label: "Vacuum ISP", value: "\(vacuumISP)", imageName: "stopwatch")
            }
            
            if let maxEngineLoss = engines.maxEngineLoss {
                InformationRow(label: "Tolerated engine loss", value: "\(maxEngineLoss) engines", imageName: "xmark.octagon")
            }
            
            if let propellant1 = engines.propellant1 {
                InformationRow(label: "Propellant 1", value: propellant1.capitalizingFirstLetter(), imageName: "drop")
            }
            
            if let propellant2 = engines.propellant2 {
                InformationRow(label: "Propellant 2", value: propellant2.capitalizingFirstLetter(), imageName: "drop.triangle")
            }
            
            if let seaLevelThrust = engines.seaLevelThrust {
                InformationRow(label: "Sea level thrust", value: "\(seaLevelThrust)", imageName: "chevron.compact.up")
            }
            
            if let vacuumThrust = engines.vacuumThrust {
                InformationRow(label: "Vacuum thrust", value: "\(vacuumThrust)", imageName: "chevron.up")
            }
            
            if let twr = engines.thrustWeightRatio {
                InformationRow(label: "Thrust/weight ratio", value: "\(twr)", imageName: "scalemass")
            }
        }
    }
}

struct RocketEnginesSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketEnginesSection(engines: FakeData.shared.falcon9!.engines!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
