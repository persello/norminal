//
//  LaunchView.swift
//  Norminal
//
//  Created by Riccardo Persello o 09/10/2020.
//

import SwiftUI
import NavigationSearchBar
import OSLog

final class LaunchSearcher: ObservableObject {
    
    var text: String = "" {
        willSet {
            // A fix for the max CPU time
            if newValue != text {
                self.objectWillChange.send()
            }
        }
    }
    
    let scopes = ["All", "Upcoming", "Past"]
    @AppStorage("com.persello.norminal.launchview.searcher.scopeselection") var scopeSelection: Int = 0 {
        willSet {
            // @Published alternative
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    private func textLaunchFilter(_ launch: Launch) -> Bool {
        let nameMatch = launch.name.uppercased().contains(text.uppercased())
        
        var astronautNameMatch: Bool = false
        if let crew = launch.getCrew() {
            for astronaut in crew {
                if astronaut.name.uppercased().contains(text.uppercased()) {
                    astronautNameMatch = true
                }
            }
        }
        
        let scopeMatch: Bool!
        switch scopeSelection {
            case 0:
                scopeMatch = true
            case 1:
                scopeMatch = launch.upcoming
            case 2:
                scopeMatch = !launch.upcoming
            default:
                scopeMatch = false
        }
        
        return (nameMatch || astronautNameMatch) && scopeMatch
    }
    
    func filterLaunches(_ launches: [Launch]) -> [Launch]? {
        
        // Time filtering
        var timeFiltered: [Launch]?
        
        switch scopeSelection {
            case 1:
                // Upcoming
                timeFiltered = launches.filter({$0.upcoming}).reversed()
            case 2:
                timeFiltered = launches.filter({!$0.upcoming})
            default:
                timeFiltered = launches
        }
        
        // When we have a query do the text filtering
        if text.count > 0 {
            return timeFiltered?.filter(textLaunchFilter(_:))
        } else {
            return timeFiltered
        }
        
    }
}

struct LaunchListView: View {
    var selectedLaunch: Binding<Launch?>?
    @StateObject private var searcher = LaunchSearcher()
    @EnvironmentObject private var globalData: SpaceXData
    
    let splogger = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: .pointsOfInterest)
    
    var launches: [Launch] {
        defer {
            os_signpost(.end, log: splogger, name: "Get launches")
        }
        os_signpost(.begin, log: splogger, name: "Get launches")
        
        return searcher.filterLaunches(globalData.launches) ?? []
    }
    
    var pastLaunches: [Launch] {
        defer {
            os_signpost(.end, log: splogger, name: "Get past launches")
        }
        os_signpost(.begin, log: splogger, name: "Get past launches")
        
        return launches.filter({!$0.upcoming}).reversed()
    }
    
    var upcomingLaunches: [Launch] {
        defer {
            os_signpost(.end, log: splogger, name: "Get upcoming launches")
        }
        os_signpost(.begin, log: splogger, name: "Get upcoming launches")
        
        return launches.filter({$0.upcoming})
    }
    
    var body: some View {
        if globalData.launches.count > 0 {
            // We have data in the globalData
            
            /*
             If I use a ZStack instead of a Group, the keyboard
             does not hide when launches.count becomes < 0 due to a search.
             */
            ZStack {
                if launches.count > 0 {
                    // The current filter is valid
                    List {
                        // Show first big tile?
                        if let nl = globalData.getNextLaunch(), searcher.text.count == 0, searcher.scopeSelection == 0 {
                            Section(header: Text("Next launch")) {
                                ZStack {
                                    LaunchListTile(launch: nl, showDetails: true)
                                    NavigationLink(destination: LaunchDetailView(launch: nl)) {
                                        EmptyView()
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .opacity(0.0)
                                }
                            }
                        }
                        
                        // Show results
                        if upcomingLaunches.count > 0 {
                            Section(header: Text("\(searcher.scopes[1]) launches")) {
                                ForEach(upcomingLaunches) { launch in
                                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                        LaunchListTile(launch: launch)
                                    }
                                }
                            }
                        }
                        
                        if pastLaunches.count > 0 {
                            Section(header: Text("\(searcher.scopes[2]) launches")) {
                                ForEach(pastLaunches) { launch in
                                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                        LaunchListTile(launch: launch)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    // The current filter returns nothing
                    VStack {
                        Text("No results")
                            .font(.title)
                        Text("No launches were found for \"\(searcher.text)\".")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Launches")
            .navigationSearchBar(
                text: $searcher.text,
                scopeSelection: $searcher.scopeSelection,
                options: [
                    .scopeButtonTitles: searcher.scopes
                ]
            )
        } else {
            // We don't have data in the globalData
            if globalData.loadingError {
                // Error occurred during data load
                LoadingErrorView()
            } else {
                // We are loading data
                LoadingView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ProgressView(label: {
            Text("Loading")
                .font(.caption)
                .foregroundColor(.secondary)
        })
    }
}

struct LoadingErrorView: View {
    var body: some View {
        VStack {
            Text("Loading error")
                .font(.title)
            Text("Please check your connection and try again.")
                .foregroundColor(.secondary)
                .font(.subheadline)
            Button("Retry", action: { SpaceXData.shared.loadAllData() })
                .buttonStyle(FilledButtonStyle())
                .padding()
        }
        .padding()
    }
}

struct FilledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 16)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8.0, style: .continuous)
                    .fill(Color.accentColor)
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}

struct LoadingErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingErrorView()
            .previewLayout(.sizeThatFits)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .previewLayout(.sizeThatFits)
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView()
            .environmentObject(SpaceXData.shared)
    }
}
