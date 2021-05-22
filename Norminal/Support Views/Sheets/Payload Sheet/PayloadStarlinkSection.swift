//
//  PayloadStarlinkSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 22/05/21.
//

import SwiftUI

struct PayloadStarlinkSection: View {
    var starlinks: [Starlink]

    var body: some View {
        Section(header: Text("Starlink")) {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Starlink")
                        .font(.largeTitle)
                        .bold()

                    if let version = starlinks.first?.version {
                        Text(version)
                            .foregroundColor(.gray)
                            .bold()
                    }
                }
            }
            .padding(.top, 4)

            InformationRow(label: "Count", value: "\(starlinks.count)", imageName: "number")
            InformationRow(label: "Decayed", value: "\(starlinks.filter({ $0.spaceTrack?.decayed ?? false }).count)", imageName: "xmark.circle")
        }
    }
}

struct PayloadStarlinkSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            PayloadStarlinkSection(starlinks: FakeData.shared.bunchOfStarlinks!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
