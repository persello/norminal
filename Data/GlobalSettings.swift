//
//  GlobalSettings.swift
//  Norminal
//
//  Created by Riccardo Persello on 28/03/21.
//

import Foundation
import SwiftUI

class GlobalSettings: ObservableObject {
    static var shared = GlobalSettings()
    
    enum Filters: String, Equatable, CaseIterable {
        case all = "All"
        case upcoming = "Upcoming"
        case past = "Past"
        
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    }
    
    enum Orderings: String, Equatable, CaseIterable {
        case auto = "Auto"
        case newest = "Newest"
        case oldest = "Oldest"
        
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
    }
    
    @AppStorage("com.persello.norminal.launchfilter.scopeselection") var launchFilterSelection: Filters = .all {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    let orderings = ["Auto", "Newest", "Oldest"]
    @AppStorage("com.persello.norminal.launchfilter.orderselection") var launchOrderSelection: Orderings = .auto {
        willSet {
            self.objectWillChange.send()
        }
    }
}
