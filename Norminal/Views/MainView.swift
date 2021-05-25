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
<<<<<<< HEAD
=======
            .navigationViewStyle(StackNavigationViewStyle())
>>>>>>> main
            .tabItem {
                Image(systemName: "flame")
                Text("Launches")
            }
<<<<<<< HEAD
            
            FeedbackView()
                .tabItem {
                    Image(systemName: "exclamationmark.bubble.fill")
                    Text("Feedback")
=======

            ArchiveView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Archive")
>>>>>>> main
                }
        }
    }
}

enum Screens: Equatable, Identifiable {
    case launches
<<<<<<< HEAD
    case feedback
    
=======
    case archive
    case astronauts
    case starlink
    case cores
    case capsules
    case payloads
    case ships
    case vehicles
    case pads
    case company
    case about

>>>>>>> main
    var id: Screens { self }
}

struct SidebarView: View {
<<<<<<< HEAD
    @State var selectedView: Screens? = .launches
    
    var body: some View {
        List {
            Group{
                NavigationLink(destination: LaunchListView(), tag: Screens.launches, selection: $selectedView) {
                    Label("Launches", systemImage: "flame")
                }
                NavigationLink(destination: FeedbackView(), tag: Screens.feedback, selection: $selectedView) {
                    Label("Feedback", systemImage: "exclamationmark.bubble")
=======
    @Binding var selectedView: Screens?
    @EnvironmentObject var globalData: SpaceXData

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
                    destination: AstronautListView(astronauts: globalData.crew),
                    tag: Screens.astronauts,
                    selection: $selectedView) {
                    Label("Astronauts", systemImage: "person.2")
                }

                NavigationLink(
                    destination: StarlinkListView(starlinks: globalData.starlinks),
                    tag: Screens.starlink,
                    selection: $selectedView) {
                    Label("Starlink", systemImage: "network")
                }

                NavigationLink(
                    destination: CoreListView(cores: globalData.cores),
                    tag: Screens.cores,
                    selection: $selectedView) {
                    Label("Cores", systemImage: "flame")
                }

                NavigationLink(
                    destination: CapsuleListView(capsules: globalData.capsules),
                    tag: Screens.capsules,
                    selection: $selectedView) {
                    Label("Capsules", systemImage: "arrowtriangle.up.circle")
                }

                NavigationLink(
                    destination: PayloadListView(payloads: globalData.payloads),
                    tag: Screens.payloads,
                    selection: $selectedView) {
                    Label("Payloads", systemImage: "shippingbox")
                }

                NavigationLink(
                    destination: ShipListView(ships: globalData.ships),
                    tag: Screens.ships,
                    selection: $selectedView) {
                    Label("Support ships", systemImage: "lifepreserver")
                }
            }

            Group {
                NavigationLink(
                    destination: VehicleListView(rockets: globalData.rockets),
                    tag: Screens.vehicles,
                    selection: $selectedView) {
                    Label("Vehicles", systemImage: "car")
                }

                NavigationLink(
                    destination: PadListView(launchpads: globalData.launchpads, landpads: globalData.landpads),
                    tag: Screens.pads,
                    selection: $selectedView) {
                    Label("Pads", systemImage: "arrow.up.arrow.down")
                }

                NavigationLink(
                    destination: CompanySheet(company: globalData.companyInfo, history: globalData.history),
                    tag: Screens.company,
                    selection: $selectedView) {
                    Label("Company", systemImage: "building.2")
                }

                NavigationLink(
                    destination: AboutView(),
                    tag: Screens.about,
                    selection: $selectedView) {
                    Label("About", systemImage: "info.circle")
>>>>>>> main
                }
            }
        }
        .listStyle(SidebarListStyle())
    }
}

struct RegularMainView: View {
    @EnvironmentObject var globalData: SpaceXData
<<<<<<< HEAD
    
    var body: some View {
        
        NavigationView {
            SidebarView()
                .navigationTitle("Norminal")
            
            LaunchListView()
            
            LaunchNotSelectedView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
=======
    @State var selectedScreen: Screens? = .launches

    var body: some View {
        if selectedScreen == .about || selectedScreen == .company {
            NavigationView {
                SidebarView(selectedView: $selectedScreen)
                    .navigationTitle("Norminal")

                EmptyView()
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        } else {
            NavigationView {
                SidebarView(selectedView: $selectedScreen)
                    .navigationTitle("Norminal")

                switch selectedScreen {
                case .launches:
                        LaunchListView()
                case .astronauts:
                    AstronautListView(astronauts: globalData.crew)
                case .starlink:
                    StarlinkListView(starlinks: globalData.starlinks)
                case .cores:
                    CoreListView(cores: globalData.cores)
                case .capsules:
                    CapsuleListView(capsules: globalData.capsules)
                case .payloads:
                    PayloadListView(payloads: globalData.payloads)
                case .ships:
                    ShipListView(ships: globalData.ships)
                case .vehicles:
                    VehicleListView(rockets: globalData.rockets)
                case .pads:
                    PadListView(launchpads: globalData.launchpads, landpads: globalData.landpads)
                default:
                    EmptyView()
                }
                
                NotSelectedView()
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
>>>>>>> main
    }
}

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
<<<<<<< HEAD
    
=======

>>>>>>> main
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
<<<<<<< HEAD
                .environmentObject(SpaceXData.shared)
                .previewDevice("iPad Air (3rd generation)")
        }
=======
                .previewDevice("iPad Air (3rd generation)")

            CompactMainView()
                .previewDevice("iPhone 12 Pro")
        }
        .environmentObject(SpaceXData.shared)
>>>>>>> main
    }
}
