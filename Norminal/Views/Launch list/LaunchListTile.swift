//
//  LaunchListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct LaunchListTile: View {
    @State var launch: Launch
    
    var body: some View {
        HStack {
            WebImage(url: launch.links?.patch?.large)
                .resizable()
                .indicator(Indicator.activity)
                .frame(width:70, height:70)
                .padding(4)

            VStack(alignment: .leading) {
                Text(launch.name)
                    .font(.headline)
                Text(String(describing: launch.getNiceDate(usePrecision: true)))
                    .font(.caption)
            }
            .padding(.horizontal, 4.0)
        }
    }
}

struct LaunchListTile_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListTile(launch: FakeData.shared.crewDragon!)
            .previewLayout(.sizeThatFits)
    }
}
