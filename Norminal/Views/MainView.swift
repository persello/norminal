//
//  ContentView.swift
//  Norminal
//
//  Created by Riccardo Persello on 09/10/2020.
//

import SwiftUI

extension Bundle {
    public var icon: UIImage? {
        if let icons = infoDictionary?["CFBundleIcons"] as? [String: Any],
           let primaryIcon = icons["CFBundlePrimaryIcon"] as? [String: Any],
           let iconFiles = primaryIcon["CFBundleIconFiles"] as? [String],
           let lastIcon = iconFiles.last {
            return UIImage(named: lastIcon)
        }
        return nil
    }
}

struct CompactMainView: View {
    var body: some View {
        TabView {
            NavigationView {
                LaunchListView()
            }
            .tabItem {
                Image(systemName: "flame")
                Text("Launches")
            }
            
            FeedbackView()
                .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                    Text("Feedback")
                }
        }
    }
}

enum Screens: Equatable, Identifiable {
    case launches
    case feedback
    
    var id: Screens { self }
}

struct SidebarView: View {
    @State var selectedView: Screens? = .launches
    
    var body: some View {
        List {
            Group{
                NavigationLink(destination: LaunchListView(), tag: Screens.launches, selection: $selectedView) {
                    Label("Launches", systemImage: "flame")
                }
                NavigationLink(destination: FeedbackView(), tag: Screens.feedback, selection: $selectedView) {
                    Label("Feedback", systemImage: "exclamationmark.bubble")
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct RegularMainView: View {
    @EnvironmentObject var globalData: SpaceXData
    
    var body: some View {
        
        NavigationView {
            SidebarView()
                .navigationTitle("Norminal")
            
            LaunchListView()
            
            LaunchNotSelectedView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                CompactMainView()
            } else {
                RegularMainView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(SpaceXData.shared)
                .previewDevice("iPad Air (3rd generation)")
        }
    }
}
