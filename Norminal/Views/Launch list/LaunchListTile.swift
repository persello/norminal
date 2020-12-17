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
        VStack(alignment: .center) {
            HStack {
            
                WebImage(url: launch.links?.patch?.large)
                    .resizable()
                    .placeholder {
                        if launch.links?.patch?.large == nil {
                            Image(systemName: "xmark.seal").foregroundColor(Color(UIColor.systemGray3))
                                .font(.system(size: 40, weight: .thin))
                        }
                    }
                    .indicator(Indicator.activity)
                    .frame(width: 70, height: 70)
                    .padding(4)

                VStack(alignment: .leading) {
                    Text(launch.name)
                        .font(.headline)
                    Text(String(describing: launch.getNiceDate(usePrecision: true)))
                        .font(.caption)
                    HStack {
                        if let crew = launch.getCrew() {
                            ForEach(crew) { astronaut in
                                AstronautPicture(astronaut: astronaut)
                                    .frame(width: 40, height: 40)
                            }
                        }
                    }
                }
                .padding(.horizontal, 4.0)
                
                Spacer()
            }
            
            if(launch.isNextLaunch) {
                VStack(alignment: .center) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("T-")
                            .lineLimit(1)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.trailing, -8)
                        Text("DD:HH:MM:SS")
                            .lineLimit(1)
                            .font(.system(size: 120, weight: .bold, design: .rounded))
                            .minimumScaleFactor(0.04)
                    }
                    .padding(.bottom, -8)
                    Divider()
                    HStack {
                        Text(launch.getLaunchpad()?.name ?? "Unknown launchpad")
                            .frame(maxWidth: .infinity)
                        Divider()
                        Text("Weather here")
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding([.top, .leading, .trailing], 24)
                .padding(.bottom, 8)
                .background(Color(UIColor.systemGray4.withAlphaComponent(0.4)))
                .clipShape(RoundedRectangle(cornerRadius: 24.0, style: .continuous))
            }
        }
    }
}

struct LaunchListTile_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListTile(launch: FakeData.shared.crewDragon!)
            .previewLayout(.sizeThatFits)
    }
}
