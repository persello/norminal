//
//  RocketFairingsSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketFairingsSection: View {
    var fairings: Launch.Fairings

    func getFairingRecoveryDescription(fairings: Launch.Fairings) -> String? {
        if let recoveryAttempt = fairings.recoveryAttempt {
            if recoveryAttempt {
                if let recovered = fairings.recovered {
                    return recovered ? "Successful" : "Unsuccessful"
                } else {
                    return "Planned"
                }
            } else {
                return "Not planned"
            }
        } else {
            return nil
        }
    }

    var body: some View {
        Section(header: Text("Fairings used in this mission")) {
            if let reused = fairings.reused {
                InformationRow(label: "Reused", value: reused ? "Yes" : "No", imageName: "arrow.3.trianglepath")
            }

            if let desc = getFairingRecoveryDescription(fairings: fairings) {
                InformationRow(label: "Recovery", value: desc, imageName: "lifepreserver")
            }

//                if let ships = fairings.ships {
//                    ForEach(ships) { ship in
//                        VStack(alignment: .leading) {
//                            Text(ship.name)
//
//                            Text("AA")
//                                .foregroundColor(.gray)
//                                .font(.callout)
//                        }
//                    }
//                }
        }
    }
}

struct RocketFairingsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketFairingsSection(fairings: FakeData.shared.nrol108!.fairings!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
