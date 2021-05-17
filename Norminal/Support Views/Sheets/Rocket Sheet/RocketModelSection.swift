//
//  RocketModelSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI
import Telescope

struct RocketModelSection: View {
    var rocket: Rocket

    var body: some View {
        Section(header: Text("Vehicle")) {
            if let imageURL = rocket.flickrImages?.first {
                TImage(RemoteImage(imageURL: imageURL))
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, -16)
            }

            VStack(alignment: .leading) {
                Text(rocket.name ?? "Unknown model")
                    .font(.title)
                    .bold()

                Text("\(rocket.stageCountDescription) \(rocket.type ?? "vehicle")\((rocket.boosters ?? 0) > 0 ? " with \(rocket.boosters!) boosters" : "")".uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)
            }

            if let manufacturer = rocket.company {
                InformationRow(label: "Manufacturer", value: manufacturer, imageName: "wrench.and.screwdriver")
            }

            if let country = rocket.country {
                InformationRow(label: "Country", value: country, imageName: "flag")
            }

            if let cost = rocket.costPerLaunch {
                InformationRow(label: "Launch cost", value: UsefulFormatters.dollarsFormatter.string(from: cost as NSNumber), imageName: "dollarsign.square")
            }

            if let successRate = rocket.successRate {
                InformationRow(label: "Success rate", value: UsefulFormatters.percentageFormatter.string(from: successRate / 100 as NSNumber), imageName: "checkmark.square")
            }
        }
        .padding(.vertical, 8)
    }
}

struct RocketModelSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketModelSection(rocket: FakeData.shared.falcon9!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
