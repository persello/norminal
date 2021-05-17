//
//  RocketPayloadWeightsSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketPayloadWeightsSection: View {
    var rocket: Rocket
    
    var body: some View {
        if let payloadWeights = rocket.payloadWeights {
            Section(header: Text("Payload capabilities")) {
                ForEach(payloadWeights, id: \.name) { pw in
                    if let name = pw.name,
                       let mass = pw.maximumMass {
                        InformationRow(label: name, value: UsefulFormatters.measurementFormatter.string(from: mass), imageName: "smallcircle.fill.circle")
                    }
                }
            }
        }
    }
}

struct RocketPayloadWeightsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketPayloadWeightsSection(rocket: FakeData.shared.falcon9!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
