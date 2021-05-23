//
//  RocketListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct RocketListTile: View {
    var rocket: Rocket

    var body: some View {
        HStack {
            Group {
                if let imageURL = rocket.flickrImages?.first {
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
                Text(rocket.name ?? "Unknown rocket")
                    .bold()

                if let desc = rocket.stageCountDescription {
                    Text(desc + " rocket")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct RocketListTile_Previews: PreviewProvider {
    static var previews: some View {
        RocketListTile(rocket: FakeData.shared.falcon9!)
    }
}
