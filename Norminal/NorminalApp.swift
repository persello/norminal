//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI
import os
import WidgetKit

// MARK: - UI

@main
struct NorminalApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
              .onAppear {
                WidgetCenter.shared.reloadAllTimelines()
              }
        }
    }
}
