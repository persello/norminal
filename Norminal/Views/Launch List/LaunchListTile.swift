//
//  LaunchListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI

struct LaunchListTile: View {
    @State var launch: Launch
    var showDetails: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                
                VStack {
                    // Recap details
                    MissionRecapView(launch: launch, showCrewWhenAvailable: true)
                }
                
                Spacer()
                
                // Show arrow in right place
                if showDetails {
                    Image(systemName: "chevron.forward")
                        .font(Font.caption.weight(.semibold))
                        .foregroundColor(Color(UIColor.tertiaryLabel))
                        .padding(.trailing, 0.5)
                }
            }
            
            // Countdown
            if showDetails {
                LaunchCountdownView()
                    .padding(.top, 16)
                    .padding(.bottom, 8)
            }
        }
        .environmentObject(launch)
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
            LaunchListTile(launch: SpaceXData.shared.getNextLaunch() ?? FakeData.shared.crewDragon!, showDetails: false)
                .preferredColorScheme(.light)
                .previewLayout(.sizeThatFits)
        }
    }
}
