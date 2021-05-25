//
//  ShipSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct ShipSheet: View {
    var ship: Ship

    var body: some View {
        List {
            ShipDetailsSection()
            ShipLocationSection()

            if let launches = ship.launches,
               launches.count > 0 {
                Section(header: Text("Missions")) {
                    ForEach(launches) { launch in
                        LaunchListTile(launch: launch)
                    }
                }
            }
        }
        .environmentObject(ship)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(ship.name))
    }
}

struct ShipSheet_Previews: PreviewProvider {
    static var previews: some View {
        ShipSheet(ship: FakeData.shared.ocisly!)
    }
}
