//
//  CrewSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/11/2020.
//

import SwiftUI

struct CrewSheet: View {
    var crew: [Astronaut]

    var body: some View {
        List {
            Section {
                ForEach(crew) { astronaut in

                    NavigationLink(destination: AstronautSheet(astronaut: astronaut)) {
                        AstronautListTile(astronaut: astronaut)
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text("Crew"))
    }
}

struct CrewSheet_Previews: PreviewProvider {
    static var previews: some View {
        CrewSheet(crew: [FakeData.shared.robertBehnken!])
    }
}
