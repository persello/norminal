//
//  LaunchView.swift
//  Norminal
//
//  Created by Riccardo Persello o 09/10/2020.
//

import SwiftUI
import NavigationSearchBar

struct LaunchView: View {
    var body: some View {
        NavigationView {
            List(0..<10) {_ in
                NavigationLink(
                    destination: LaunchDetailView(launch: FakeLaunches.shared.crewDragon!)
                        
                ) {
                    LaunchListTile(launch: .constant(FakeLaunches.shared.crewDragon!))
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
