//
//  ShipListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct ShipListView: View {
    var ships: [Ship]

    var body: some View {
        Group {
            if ships.count > 0 {
                List {
                    ForEach(ships) { ship in
                        NavigationLink(destination: ShipSheet(ship: ship)) {
                            ShipListTile(ship: ship)
                        }
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 16))
                    }
                }
                .listStyle(GroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "lifepreserver")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No ships available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Support ships"))
    }
}

struct ShipListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ShipListView(ships: [FakeData.shared.ocisly!, FakeData.shared.ocisly!])
        }
    }
}
