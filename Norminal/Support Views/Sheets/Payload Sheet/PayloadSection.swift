//
//  PayloadSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct PayloadSection: View {
    var payload: Payload

    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(payload.name ?? "Unknown payload")
                    .font(.title)
                    .bold()

                if let manufacturers = payload.manufacturers {
                    Text(ListFormatter().string(from: manufacturers) ?? "")
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .font(.callout)
                }
            }
            .padding(.vertical, 4)

            if let launch = payload.launch {
                LaunchListTile(launch: launch)
            }

            if let type = payload.type {
                InformationRow(label: "Type",
                               value: type,
                               imageName: "person.crop.square.fill.and.at.rectangle")
            }

            // It makes no sense to show it, given the fact that normal payloads can't be reused. Hidden when false.
            if let reused = payload.reused,
               reused {
                InformationRow(label: "Reused",
                               value: reused ? "Yes" : "No",
                               imageName: "arrow.3.trianglepath")
            }

            if let customers = payload.customers {
                InformationRow(label: "Customers",
                               value: ListFormatter().string(from: customers),
                               imageName: "dollarsign.square")
            }
            
            if let nationalities = payload.nationalities {
                InformationRow(label: "Nationalities",
                               value: ListFormatter().string(from: nationalities),
                               imageName: "flag")
            }
            
            if let mass = payload.mass {
                InformationRow(label: "Mass",
                               value: UsefulFormatters.measurementFormatter.string(for: mass),
                               imageName: "scalemass")
            }
        }
    }
}

struct PayloadSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadSection(payload: FakeData.shared.starlink22Payload!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
