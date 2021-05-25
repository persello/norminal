//
//  PadListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct PadListView: View {
    var launchpads: [Launchpad]
    var landpads: [Landpad]

    var body: some View {
        List {
            Section(header: Text("Launchpads")) {
                ForEach(launchpads) { launchpad in
                    NavigationLink(destination: LaunchpadSheet(launchpad: launchpad)) {
                        Text(launchpad.name)
                    }
                }
            }

            Section(header: Text("Landpads")) {
                ForEach(landpads) { landpad in
                    NavigationLink(destination: LandpadSheet(landpad: landpad)) {
                        Text(landpad.name)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text("Pads"))
    }
}

struct PadListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PadListView(launchpads: [FakeData.shared.slc40!], landpads: [FakeData.shared.lz1!])
        }
    }
}
