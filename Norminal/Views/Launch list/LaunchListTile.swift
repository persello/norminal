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
  var showDetails: Bool = false

  var body: some View {
    VStack(alignment: .center) {
      HStack {

        WebImage(url: launch.links?.patch?.large)
          .resizable()
          .placeholder {
            if launch.links?.patch?.large == nil {
              Image(systemName: "xmark.seal")
                .foregroundColor(.gray)
                .font(.system(size: 40, weight: .thin))
                .frame(width: 70, height: 70)
                .background(Circle().foregroundColor(Color(UIColor.systemGray6)))
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

        // Show arrow in right place
        if showDetails {
          Image(systemName: "chevron.forward")
            .font(Font.caption.weight(.semibold))
            .foregroundColor(Color(UIColor.tertiaryLabel))
            .padding(.trailing, 0.5)
        }
      }

      if showDetails {
        LaunchCountdownView(launch: launch)
          .padding(.top, 16)
          .padding(.bottom, 8)
      }
    }
  }
}

struct LaunchListTile_Previews: PreviewProvider {
  static var previews: some View {
    Group {
        LaunchListTile(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!, showDetails: true)
          .frame(width: 350, height: 150, alignment: .center)
            .previewLayout(.fixed(width: 350, height: 400))
        LaunchListTile(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!, showDetails: true)
            .preferredColorScheme(.dark)
            .frame(width: 350, height: 150, alignment: .center)
            .previewLayout(.fixed(width: 350, height: 400))
    }
  }
}
