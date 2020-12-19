//
//  LaunchView.swift
//  Norminal
//
//  Created by Riccardo Persello o 09/10/2020.
//

import SwiftUI
import NavigationSearchBar

struct LaunchView: View {
    @ObservedObject private var data = SpaceXData.shared
    
    var body: some View {
        NavigationView {
            List {
                
                // Next launch
                if let nl = data.getNextLaunch() {
                    Section(header: Text("Next launch")) {
                        ZStack {
                            LaunchListTile(launch: nl, showDetails: true)
                            NavigationLink(destination: LaunchDetailView(launch: nl)) {
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            .opacity(0.0)
                        }
                    }
                }
                
                // Launch list
                Section(header: Text("All launches")) {
                    ForEach(data.launches.reversed()) { launch in
                        NavigationLink(destination: LaunchDetailView(launch: launch)) {
                            LaunchListTile(launch: launch)
                        }
                        
                    }
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Launches")
            .navigationSearchBar(text: .constant(""))
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
