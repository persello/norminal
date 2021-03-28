//
//  LaunchListView.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var globalData: SpaceXData
    @State var selectedLaunch: Launch?
    
    var launches: [Launch] {
        return globalData.launches
    }
    
    var body: some View {
        List(launches) { launch in
            NavigationLink(destination: DetView(launch: launch)) {
                LaunchListTile(launch: launch, showDetails: false)
            }
        }
        .frame(minWidth: 350)
        .navigationTitle("Launches")
        .navigationSubtitle("\(globalData.launches.count) launches")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { /* Open filters */ }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
            }
        }
    }
}

struct DetView: View {
    var launch: Launch
    var body: some View {
        Text(launch.name)
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
            .environmentObject(SpaceXData.shared)
    }
}
