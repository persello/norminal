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
                ForEach(data.launches.reversed()) { launch in
                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                        LaunchListTile(launch: launch)
                    }
                }

            }
                .navigationBarTitle("Launches")
                .navigationSearchBar(text: .constant(""))
        }
        // .onAppear()
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
