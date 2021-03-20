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
                    .tabItem {
                        Image(systemName: "flame")
                        Text("Launches")
                    }
            }
            
            VStack {
                HStack {
                    if let icon = Bundle.main.icon {
                        Image(uiImage: icon)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 12,
                                                 style: .continuous))
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Norminal")
                            .font(.title)
                        Text("v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                }
                Link(destination: URL(string: "https://forms.gle/1pzmsASLWYjEPnU5A")!, label: {
                    Text("Join the Alpha channel")
                })
                .padding(48)
            }
            .tabItem {
                Image(systemName: "exclamationmark.bubble.fill")
                Text("Feedback")
            }
        }
    }
}

struct SidebarView: View {
    var body: some View {
        List {
            Label("Launches", systemImage: "flame")
            Label("Feedback", systemImage: "exclamationmark.bubble")
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Norminal")
    }
}

struct RegularMainView: View {
    var body: some View {
        NavigationView {
            SidebarView()
            LaunchListView()
            LaunchDetailView(launch: FakeData.shared.crewDragon!)
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if horizontalSizeClass == .compact {
            CompactMainView()
        } else {
            RegularMainView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(SpaceXData.shared)
    }
}
