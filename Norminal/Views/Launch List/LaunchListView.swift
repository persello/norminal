//
//  LaunchView.swift
//  Norminal
//
//  Created by Riccardo Persello o 09/10/2020.
//

import SwiftUI
import NavigationSearchBar

final class LaunchSearcher: ObservableObject {
    
    init(data: SpaceXData) {
        self.data = data
        filteredLaunches = data.launches
    }
    
    @ObservedObject private var data: SpaceXData
    
    var text: String = "" {
        didSet {
            if text != oldValue {
                updateLaunches()
            }
        }
    }
    
    let scopes = ["All", "Upcoming", "Past"]
    @AppStorage("com.persello.norminal.launchview.searcher.scopeselection") var scopeSelection: Int = 0 {
        didSet {
            if scopeSelection != oldValue {
                updateLaunches()
            }
        }
    }
    
    private func launchFilter(_ launch: Launch) -> Bool {
        let nameMatch = launch.name.uppercased().contains(text.uppercased())
        
        var astronautNameMatch: Bool = false
        if let crew = launch.getCrew() {
            for astronaut in crew {
                if astronaut.name.uppercased().contains(text.uppercased()) {
                    astronautNameMatch = true
                }
            }
        }
        
        return nameMatch || astronautNameMatch
    }
    
    private func updateLaunches() {
        
        // Time filtering
        var timeFiltered: [Launch]?
        
        switch scopeSelection {
            case 1:
                // Upcoming
                timeFiltered = data.launches.filter({$0.upcoming}).reversed()
            case 2:
                timeFiltered = data.launches.filter({!$0.upcoming})
            default:
                timeFiltered = data.launches
        }
        
        // When we have a query do the text filtering
        if text.count > 0 {
            filteredLaunches = timeFiltered?.filter(launchFilter(_:))
        } else {
            filteredLaunches = timeFiltered
        }
        
    }
    
    @Published var filteredLaunches: [Launch]?
}

struct LaunchListView: View {
    @ObservedObject private var searcher = LaunchSearcher(data: SpaceXData.shared)
    
    var body: some View {
        NavigationView {
            if SpaceXData.shared.launches.count > 0 {
                List {
                    
                    // Next launch
                    if let nl = SpaceXData.shared.getNextLaunch(), searcher.text.count == 0, searcher.scopeSelection == 0 {
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
                    
                    // Launch list
                    if let launches = searcher.filteredLaunches {
                        if searcher.scopeSelection == 0 {
                            // When showing all launches, split them
                            Section(header: Text("\(searcher.scopes[1]) launches")) {
                                ForEach(launches.filter({$0.upcoming}).reversed()) { launch in
                                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                        LaunchListTile(launch: launch)
                                    }
                                }
                            }
                            
                            Section(header: Text("\(searcher.scopes[2]) launches")) {
                                ForEach(launches.filter({!$0.upcoming}).reversed()) { launch in
                                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                        LaunchListTile(launch: launch)
                                    }
                                }
                            }
                        } else {
                            // Everything in one section otherwise
                            Section(header: Text("\(searcher.scopes[searcher.scopeSelection]) launches")) {
                                ForEach(launches.reversed()) { launch in
                                    NavigationLink(destination: LaunchDetailView(launch: launch)) {
                                        LaunchListTile(launch: launch)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Launches")
                .navigationSearchBar(
                    text: $searcher.text,
                    scopeSelection: $searcher.scopeSelection,
                    options: [
                        .scopeButtonTitles: searcher.scopes
                    ]
                )
            } else {
                if SpaceXData.shared.loadingError {
                    LoadingErrorView()
                } else {
                    LoadingView()
                }
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
            Button("__NOT_IMPLEMENTED__", action: {})
                .buttonStyle(FilledButtonStyle())
                .padding(.horizontal, 48)
        }
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
    }
}
