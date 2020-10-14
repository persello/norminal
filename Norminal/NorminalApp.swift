//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI
import os

// MARK: - Log setup
extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let spaceXData = OSLog(subsystem: subsystem, category: "SpaceX data")
    static let fakeData = OSLog(subsystem: subsystem, category: "Fake data generator")
}

// MARK: - UI

@main
struct NorminalApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
