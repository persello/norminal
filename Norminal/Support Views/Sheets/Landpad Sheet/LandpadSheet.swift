//
//  LandpadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct LandpadSheet: View {
    var landpad: Landpad

    var body: some View {
        List {
            LandpadHeaderSection()
            
            LandpadMapSection()

            if let launches = landpad.launches,
               launches.count > 0 {
                Section(header: Text("\(launches.count) launches")) {
                    ForEach(launches) { launch in
                        LaunchListTile(launch: launch)
                    }
                }
            }
        }
        .environmentObject(landpad)
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(landpad.name))
    }
}

struct LandpadSheet_Previews: PreviewProvider {
    static var previews: some View {
        LandpadSheet(landpad: FakeData.shared.lz1!)
    }
}
