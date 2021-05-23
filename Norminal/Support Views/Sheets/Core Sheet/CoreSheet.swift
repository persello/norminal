//
//  CoreSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct CoreSheet: View {
    var core: Core

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Text(core.serial)
                        .font(.title)
                        .bold()

                    if let block = core.block {
                        Text("Block \(block)".uppercased())
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .font(.callout)
                    }

                    if let lastUpdate = core.lastUpdate {
                        Text(lastUpdate.capitalizingFirstLetter())
                            .padding(.top, 4)
                            .font(.system(.body, design: .serif))
                    }
                }
                .padding(.vertical, 4)

                InformationRow(label: "Status",
                               value: core.status.rawValue.capitalizingFirstLetter(),
                               imageName: "questionmark")

                if let reuseCount = core.reuseCount {
                    InformationRow(label: "Reuse count",
                                   value: "\(reuseCount)",
                                   imageName: "arrow.3.trianglepath")
                }

                if let rtlsLandings = core.rtlsLandings,
                   let rtlsAttempts = core.rtlsAttempts {
                    InformationRow(label: "RTLS landings",
                                   value: "\(rtlsLandings)/\(rtlsAttempts)",
                                   imageName: "arrow.down.to.line")
                }

                if let asdsLandings = core.asdsLandings,
                   let asdsAttempts = core.asdsAttempts {
                    InformationRow(label: "ASDS landings",
                                   value: "\(asdsLandings)/\(asdsAttempts)",
                                   imageName: "arrow.down.to.line")
                }
            }

            if let launches = core.launches,
               launches.count > 0 {
                Section(header: Text("Launches")) {
                    ForEach(launches) { launch in
                        LaunchListTile(launch: launch)
                    }
                }
            }
        }
        .environmentObject(core)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(core.serial)
    }
}

struct CoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        CoreSheet(core: FakeData.shared.b1051!)
    }
}
