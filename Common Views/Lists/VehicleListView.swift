//
//  VehicleListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct VehicleListView: View {
    var rockets: [Rocket]

    var body: some View {
        List {
            ForEach(rockets) { rocket in
                NavigationLink(destination: RocketSheet(rocket: rocket)) {
                    RocketListTile(rocket: rocket)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text("Vehicles"))
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VehicleListView(rockets: [FakeData.shared.falcon9!])
        }
    }
}
