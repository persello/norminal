//
//  ArchiveListViews.swift
//  Norminal
//
//  Created by Riccardo Persello on 22/05/21.
//

import SwiftUI

struct CapsuleListView: View {
    struct CapsuleView: View {
        var capsule: Capsule
        var body: some View {
            List {
                PayloadCapsuleInstanceSections(capsule: capsule)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Capsule"))
        }
    }
    
    var capsules: [Capsule]

    var body: some View {
        Group {
            if capsules.count > 0 {
                List {
                    ForEach(capsules) { capsule in
                        NavigationLink(destination: CapsuleView(capsule: capsule)) {
                            VStack(alignment: .leading) {
                                Text(capsule.serial)
                                    .bold()

                                if let model = capsule.dragonModel?.name {
                                    Text(model)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No capsules available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Capsules"))
    }
}

struct CoreListView: View {
    var cores: [Core]

    var body: some View {
        Group {
            if cores.count > 0 {
                List {
                    ForEach(cores) { core in
                        NavigationLink(destination: CoreSheet(core: core)) {
                            VStack(alignment: .leading) {
                                Text(core.serial)
                                    .bold()

                                if let block = core.block {
                                    Text("Block \(block)")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No cores available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Rocket cores"))
    }
}

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

struct ArchiveListViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                StarlinkListView(starlinks: FakeData.shared.bunchOfStarlinks!)
            }

            NavigationView {
                CoreListView(cores: [FakeData.shared.b1051!, FakeData.shared.b1051!])
            }

            NavigationView {
                CapsuleListView(capsules: [FakeData.shared.c207!, FakeData.shared.c207!])
            }
        }
    }
}
