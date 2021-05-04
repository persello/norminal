//
//  DetailsSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 03/05/21.
//

import MapKit
import SwiftUI

struct DetailsSheet: View {
    var launch: Launch

    @State private var region: MKCoordinateRegion?
    @State private var regionLoaded = false

    @Binding var modalShown: Bool

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Details")
                            .font(.title.bold())
                        Text(launch.details ?? "")
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 0))
                }

                if regionLoaded {
                    Section(header: Text("Map")) {
                        Map(coordinateRegion: Binding($region)!)
                            .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                            .aspectRatio(0.618 * 2, contentMode: .fill)
                        Text("Legend...")
                        Text("🛥")
                        Text("🚀")
                        Text("AAA")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text(launch.name))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
            .onAppear {
                if let launchpadLocation = launch.launchpad?.location {
                    region = MKCoordinateRegion(center: launchpadLocation, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
                    regionLoaded = true
                }
            }
        }
    }
}

struct DetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSheet(launch: FakeData.shared.nrol108!, modalShown: .constant(true))
    }
}
