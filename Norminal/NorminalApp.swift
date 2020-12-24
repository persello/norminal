//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import Firebase
import SwiftUI
import os

// MARK: - UI

@main
struct NorminalApp: App {
  var body: some Scene {
    WindowGroup {
      MainView()
        .onAppear {
          
          // Firebase
          FirebaseApp.configure()
        }
    }
  }
}
