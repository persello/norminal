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

    var percentageFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.locale = Locale.current
        f.numberStyle = .percent
        return f
    }

    var currencyFormatter: NumberFormatter {
        let f = NumberFormatter()
        f.minimumFractionDigits = 0
        f.locale = Locale(identifier: "en_US")
        f.numberStyle = .currency
        return f
    }

    var measurementFormatter: MeasurementFormatter {
        let f = MeasurementFormatter()
        f.numberFormatter.minimumFractionDigits = 0
        f.numberFormatter.maximumFractionDigits = 2
        f.numberFormatter.roundingMode = .halfEven
        f.unitOptions = .naturalScale

        return f
    }

    var body: some View {
        List {
            Section(header: Text("Cores used in this mission")) {
                if let coreInstances = launch.cores {
                    ForEach(coreInstances) { core in
                        VStack(alignment: .leading) {
                            Text(core.nameWithFlight)

                            Text(core.recoveryStatus)
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                }
            }

            if let rocket = launch.rocket {
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

                        Text("\(rocket.stageCountDescription) \(rocket.type ?? "vehicle")".uppercased())
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
                        InformationRow(label: "Launch cost", value: currencyFormatter.string(from: cost as NSNumber), imageName: "dollarsign.square")
                    }

                    if let successRate = rocket.successRate {
                        InformationRow(label: "Success rate", value: percentageFormatter.string(from: successRate / 100 as NSNumber), imageName: "checkmark.square")
                    }
                }
                .padding(.vertical, 8)

                Section(header: Text("Physical specifications")) {
                    if let height = rocket.height {
                        InformationRow(label: "Height", value: measurementFormatter.string(from: height), imageName: "arrow.up.and.down")
                    }

                    if let diameter = rocket.diameter {
                        InformationRow(label: "Diameter", value: measurementFormatter.string(from: diameter), imageName: "arrow.left.and.right.circle")
                    }

                    if let mass = rocket.mass {
                        InformationRow(label: "Mass", value: measurementFormatter.string(from: mass), imageName: "scalemass")
                    }
                }

                if let payloadWeights = rocket.payloadWeights {
                    Section(header: Text("Payload capabilities")) {
                        ForEach(payloadWeights, id: \.name) { pw in
                            if let name = pw.name,
                               let mass = pw.maximumMass {
                                InformationRow(label: name, value: measurementFormatter.string(from: mass), imageName: "smallcircle.fill.circle")
                            }
                        }
                    }
                }

                Section(header: Text("Stages")) {
                }

                Section(header: Text("Engines")) {
                }

                // TODO: Images
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch.rocket?.name ?? "Rocket"))
    }
}

struct RocketSheet_Previews: PreviewProvider {
    static var previews: some View {
        RocketSheet(launch: FakeData.shared.trailblazer!)
    }
}
