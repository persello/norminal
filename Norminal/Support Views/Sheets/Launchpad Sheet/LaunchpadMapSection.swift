//
//  LaunchpadMapSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import MapKit
import SwiftUI

struct LaunchpadMapSection: View {
    @EnvironmentObject var launchpad: Launchpad

    @State var region: MKCoordinateRegion?

    var body: some View {
        Section(header: Text("Map")) {
            VStack(alignment: .leading) {
                if region != nil {
                    Map(coordinateRegion: Binding($region)!, annotationItems: [launchpad]) { item in
                        MapPin(coordinate: item.location)
                    }
                    .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                    .aspectRatio(0.618 * 2, contentMode: .fill)
                }

                VStack(alignment: .leading) {
                    Text(launchpad.locality)
                        .font(.title.bold())
                    Text(launchpad.region)
                        .foregroundColor(.gray)
                }
                .padding(.init(top: 15, leading: 5, bottom: 15, trailing: 0))
                .onAppear {
                    region = MKCoordinateRegion(center: launchpad.location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
            }
        }
    }
}

struct LaunchpadMapSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LaunchpadMapSection()
        }
        .listStyle(InsetGroupedListStyle())
        .environmentObject(FakeData.shared.slc40!)
        .previewLayout(.sizeThatFits)
    }
}
