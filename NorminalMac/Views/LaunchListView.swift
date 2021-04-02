//
//  LaunchListView.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

struct LaunchListView: View {
    @EnvironmentObject var globalData: SpaceXData
    @ObservedObject var globalSettings = GlobalSettings.shared
    @ObservedObject var filter = LaunchFilter()
    @State var selectedLaunch: Launch?

    var launches: [Launch] {
        return filter.filterLaunches(globalData.launches) ?? []
    }
    
    var body: some View {
        List {
            ForEach(launches, id: \.id) {launch in
                NavigationLink(destination: DetView(launch: launch)) {
                    LaunchListTile(launch: launch, showDetails: false)
                        .frame(maxHeight: 90)
                }
            }
        }
        .frame(minWidth: 350)
        .navigationTitle("Launch history")
        .navigationSubtitle("\(globalData.launches.count) launches")
        .touchBar(TouchBar {
            Spacer(minLength: 50)
                LaunchOrderingControls()
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 16)
        })
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Menu {
                    LaunchOrderingControls()
                }
                label: {
                    Label("Launch filter", systemImage: "eyeglasses")
                }
                
                SearchBar(search: $filter.text)
            }
        }
    }
}

struct DetView: View {
    var launch: Launch?
    var body: some View {
        Group {
            if let launch = launch {
                Text(launch.name)
            } else {
                LaunchNotSelectedView()
            }
        }
        .frame(minWidth: 500)
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
            .environmentObject(SpaceXData.shared)
    }
}
