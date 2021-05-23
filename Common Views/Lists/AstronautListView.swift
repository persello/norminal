//
//  AstronautListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct AstronautListView: View {
    var astronauts: [Astronaut]
    var body: some View {
        List {
            ForEach(astronauts) { astronaut in
                NavigationLink(destination: AstronautSheet(astronaut: astronaut)) {
                    AstronautListTile(astronaut: astronaut)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text("Astronauts"))
    }
}

struct AstronautListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AstronautListView(astronauts: [FakeData.shared.robertBehnken!, FakeData.shared.robertBehnken!])
        }
    }
}
