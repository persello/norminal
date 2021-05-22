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

            ArchiveView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Archive")
                }
        }
    }
}

enum Screens: Equatable, Identifiable {
    case launches
    case archive

    case astronauts
    case starlink
    case cores
    case capsules
    case payloads
//    case roadster
    case ships
//    case fairings
    case vehicles // Rockets and dragons
    case pads
    case company

    case about

    var id: Screens { self }
}

struct SidebarView: View {
    @State var selectedView: Screens? = .launches

    var body: some View {
        List {
            Group {
                NavigationLink(
                    destination: LaunchListView(),
                    tag: Screens.launches,
                    selection: $selectedView) {
                    Label("Launches", systemImage: "calendar")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.astronauts,
                    selection: $selectedView) {
                    Label("Astronauts", systemImage: "person.2")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.starlink,
                    selection: $selectedView) {
                    Label("Starlink", systemImage: "network")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.cores,
                    selection: $selectedView) {
                    Label("Cores", systemImage: "flame")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.capsules,
                    selection: $selectedView) {
                    Label("Capsules", systemImage: "arrowtriangle.up.circle")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.payloads,
                    selection: $selectedView) {
                    Label("Payloads", systemImage: "shippingbox")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.ships,
                    selection: $selectedView) {
                    Label("Support ships", systemImage: "lifepreserver")
                }
            }

            Group {

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.vehicles,
                    selection: $selectedView) {
                    Label("Vehicles", systemImage: "car")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.pads,
                    selection: $selectedView) {
                    Label("Pads", systemImage: "arrow.up.arrow.down")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.company,
                    selection: $selectedView) {
                    Label("Company", systemImage: "building.2")
                }

                NavigationLink(
                    destination: EmptyView(),
                    tag: Screens.about,
                    selection: $selectedView) {
                    Label("About", systemImage: "info.circle")
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
                .previewDevice("iPad Air (3rd generation)")
            
            
            CompactMainView()
                .previewDevice("iPhone 12 Pro")
        }
        .environmentObject(SpaceXData.shared)
    }
}
