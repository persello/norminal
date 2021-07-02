//
//  AstronautListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct AstronautListView: View {
    @State var astronauts: [Astronaut]?
    @State var loadingError: Bool = false

    func loadAstronauts() {
        Astronaut.loadAll { result in
            switch result {
            case .failure:
                loadingError = true
            case let .success(astronauts):
                self.astronauts = astronauts
            }
        }
    }

    var body: some View {
        List {
            if let astronauts = astronauts {
                ForEach(astronauts) { astronaut in
                    NavigationLink(destination: AstronautSheet(astronaut: astronaut)) {
                        AstronautListTile(astronaut: astronaut)
                    }
                }
            } else {
                if loadingError {
                    LoadingErrorView(reloadAction: loadAstronauts)
                } else {
                    ProgressView()
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text("Astronauts"))
        .onAppear {
            loadAstronauts()
        }
    }
}

struct AstronautListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AstronautListView(astronauts: [FakeData.shared.robertBehnken!, FakeData.shared.robertBehnken!])
        }
    }
}
