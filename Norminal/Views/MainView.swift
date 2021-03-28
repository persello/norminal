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

enum ViewSelection {
    case launchList
    case feedback
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

struct SidebarView: View {
    @Binding var selectedView: ViewSelection
    
    var body: some View {
        List {
            Button(action: {selectedView = .launchList}) {
                Label("Launches", systemImage: "flame")
            }
            .buttonStyle(SidebarButtonStyle().active(selectedView == .launchList))
            
            Button(action: {selectedView = .feedback}) {
                Label("Feedback", systemImage: "exclamationmark.bubble")
            }
            .buttonStyle(SidebarButtonStyle().active(selectedView == .feedback))
            
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Norminal")
    }
}

struct RegularMainView: View {
    @EnvironmentObject var globalData: SpaceXData
    @State var selectedView = ViewSelection.launchList
    
    var body: some View {
        
        switch selectedView {
        case .launchList:
            NavigationView {
                SidebarView(selectedView: $selectedView)
                LaunchListView()
                if let nextLaunch = globalData.getNextLaunch() {
                    LaunchDetailView(launch: nextLaunch)
                } else {
                    VStack {
                        Text("No details available")
                            .font(.title)
                        Text("Select a launch from the sidebar.")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
                
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
            
        case .feedback:
            NavigationView {
                SidebarView(selectedView: $selectedView)
                FeedbackView()
            }
        }
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
            
            SidebarView(selectedView: .constant(.launchList))
                .previewLayout(.sizeThatFits)
        }
    }
}
