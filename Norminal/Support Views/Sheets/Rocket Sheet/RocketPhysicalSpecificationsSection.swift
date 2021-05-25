//
//  RocketPhysicalSpecificationsSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketPhysicalSpecificationsSection: View {
    var rocket: Rocket

    var body: some View {
        Section(header: Text("Physical specifications")) {
            if let height = rocket.height {
                InformationRow(label: "Height", value: UsefulFormatters.measurementFormatter.string(from: height), imageName: "arrow.up.and.down")
            }

            if let diameter = rocket.diameter {
                if (rocket.boosters ?? 0) > 0 {
                    InformationRow(label: "Width", value: UsefulFormatters.measurementFormatter.string(from: diameter), imageName: "arrow.left.and.right")
                } else {
                    InformationRow(label: "Diameter", value: UsefulFormatters.measurementFormatter.string(from: diameter), imageName: "arrow.left.and.right.circle")
                }
            }

            if let mass = rocket.mass {
                InformationRow(label: "Mass", value: UsefulFormatters.measurementFormatter.string(from: mass), imageName: "scalemass")
            }
        }
    }
}

struct RocketPhysicalSpecificationsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketPhysicalSpecificationsSection(rocket: FakeData.shared.falcon9!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
