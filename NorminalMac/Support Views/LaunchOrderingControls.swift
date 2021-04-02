//
//  LaunchOrderingControls.swift
//  Norminal for Mac
//
//  Created by Riccardo Persello on 28/03/21.
//

import SwiftUI

struct LaunchOrderingControls: View {
    @StateObject var globalSettings = GlobalSettings.shared
    
    var body: some View {
        Picker(selection: $globalSettings.launchFilterSelection,
               label: Label("Filter", systemImage: "line.horizontal.3.decrease.circle")) {
            ForEach(GlobalSettings.Filters.allCases, id: \.self) { filter in
                Text(filter.localizedName).tag(filter)
            }
        }
        
        Picker(selection: $globalSettings.launchOrderSelection, label: Label("Order", systemImage: "arrow.up.arrow.down.circle")) {
            ForEach(GlobalSettings.Orderings.allCases, id: \.self) { ordering in
                Text(ordering.localizedName).tag(ordering)
            }
        }
    }
}

struct LaunchOrderingControls_Previews: PreviewProvider {
    static var previews: some View {
        LaunchOrderingControls()
    }
}
