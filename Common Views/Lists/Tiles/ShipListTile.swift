//
//  ShipListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct ShipListTile: View {
    var ship: Ship
    
    var body: some View {
        HStack {
            Group {
                if let imageURL = ship.image {
                    TImage(RemoteImage(imageURL: imageURL))
                        .resizable()
                        .clipped()
                        .aspectRatio(1, contentMode: .fill)
                } else {
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 56, height: 56, alignment: .center)

            VStack(alignment: .leading) {
                Text(ship.name)
                    .bold()

                if let roles = ship.roles,
                   let rolesText = ListFormatter().string(from: roles) {
                    Text(rolesText)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct ShipListTile_Previews: PreviewProvider {
    static var previews: some View {
        ShipListTile(ship: FakeData.shared.ocisly!)
    }
}
