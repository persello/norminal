//
//  NorminalMacApp.swift
//  NorminalMac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI
import Foundation
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct NorminalMacApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @ObservedObject var globalData = SpaceXData.shared
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(globalData)
                .touchBar(TouchBar {
                    Button(action: SidebarView.toggle, label: {
                        Image(systemName: "sidebar.leading")
                            .frame(width: 48)
                    })
                })
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            CommandGroup(after: CommandGroupPlacement.sidebar) {
                Menu("Launches") {
                    LaunchOrderingControls()
                }
                Divider()
            }
        }
    }
}
