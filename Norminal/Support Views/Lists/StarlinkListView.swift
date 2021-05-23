//
//  StarlinkListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct StarlinkListView: View {
    struct StarlinkView: View {
        var starlinks: [Starlink]
        var body: some View {
            List {
                PayloadStarlinkSection(starlinks: starlinks)
                if let tles = starlinks
                    .filter({ $0.spaceTrack?.decayed ?? false == false })
                    .compactMap({ $0.spaceTrack?.tle }),
                    tles.count > 0 {
                    PayloadOrbitSection(tle: tles)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }

    var starlinks: [Starlink]

    var launches: [Launch] {
        let unfiltered = starlinks.compactMap({ $0.launch })

        var unique: [Launch] = []

        for launch in unfiltered {
            if !unique.contains(launch) {
                unique.append(launch)
            }
        }

        return unique
    }

    var body: some View {
        Group {
            if launches.count > 0 {
                List {
                    ForEach(launches) { launch in
                        NavigationLink(destination: StarlinkView(starlinks: starlinks.filter({ $0.launch == launch }))) {
                            LaunchListTile(launch: launch)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "network")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No Starlink launches available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Starlink launches"))
    }
}

struct StarlinkListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StarlinkListView(starlinks: FakeData.shared.bunchOfStarlinks!)
        }
    }
}
