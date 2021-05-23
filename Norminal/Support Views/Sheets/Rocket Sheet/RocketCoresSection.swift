//
//  RocketCoresSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI

struct RocketCoresSection: View {
    var cores: [Launch.CoreInstance]
    var upcoming: Bool
    var body: some View {
        Section(header: Text("Cores used in this mission")) {
            ForEach(cores) { core in
                NavigationLink(destination: core.realCore != nil ? CoreSheet(core: core.realCore!) : nil) {
                    VStack(alignment: .leading) {
                        Text(core.nameDotFlight)
                        if !upcoming {
                            Text(core.recoveryStatus)
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                }
            }
        }
    }
}

struct RocketCoresSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketCoresSection(cores: FakeData.shared.nrol108!.cores!, upcoming: false)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
