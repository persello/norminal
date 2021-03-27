//
//  NorminalApp.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

#if !os(macOS) && !targetEnvironment(macCatalyst)
import Firebase
#endif

import SwiftUI
import os
import WidgetKit

// MARK: - UI

@main
struct NorminalApp: App {
    @ObservedObject var globalData = SpaceXData.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    
                    // Widget
                    DispatchQueue.global(qos: .background).async {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    
                    #if !os(macOS) && !targetEnvironment(macCatalyst)
                    // Firebase
                    FirebaseApp.configure()
                    #endif
                }
                .environmentObject(globalData)
        }
    }
}
