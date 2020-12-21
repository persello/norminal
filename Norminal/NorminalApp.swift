//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI
import os
import WidgetKit
import Sentry

// MARK: - UI

@main
struct NorminalApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
        .onAppear {
          
          // Refresh widget
          WidgetCenter.shared.reloadAllTimelines()
          
          // Sentry analytics
          SentrySDK.start { options in
            options.dsn = "https://d638192f58b14abb893655e6376effce@o494729.ingest.sentry.io/5566317"
            options.debug = true // Enabled debug when first installing is always helpful
            options.sessionTrackingIntervalMillis = 60000
            options.attachStacktrace = true
          }
        }
    }
  }
}
