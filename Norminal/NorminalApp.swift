//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import Firebase
import os
import SwiftUI
import WidgetKit

// MARK: - UI

@main
struct NorminalApp: App {
    init() {
        // Widget
        DispatchQueue.global(qos: .background).async {
            WidgetCenter.shared.reloadAllTimelines()
        }

        // Firebase
        FirebaseApp.configure()
    }

    @ObservedObject var globalData = SpaceXData.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(globalData)
        }
    }
}
