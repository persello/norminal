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

struct SidebarButtonStyle: ButtonStyle {
    private var isActive: Bool = false
    
    func getForegroundColor(configuration: Configuration) -> Color? {
        return configuration.isPressed ? .secondary : nil
    }
    
    func getBackgroundColor(configuration: Configuration) -> Color {
        if isActive {
            return Color(UIColor.secondarySystemFill)
        } else {
            return .clear
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(getForegroundColor(configuration: configuration))
            .padding(.vertical, 10)
            .padding(.leading, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10.0, style: .continuous)
                    .fill(getBackgroundColor(configuration: configuration))
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
            .padding(.horizontal, -8)
            .padding(.vertical, -10)
    }
    
    func active(_ a: Bool = true) -> SidebarButtonStyle {
        var style = self
        style.isActive = a
        return style
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
