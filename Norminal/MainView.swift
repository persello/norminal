//
//  ContentView.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            LaunchView()
                .tabItem { Image(systemName: "flame")
                    Text("Launches")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
