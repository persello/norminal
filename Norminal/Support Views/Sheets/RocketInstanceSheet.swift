//
//  RocketSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 13/05/21.
//

import SwiftUI

struct RocketInstanceSheet: View {
    var launch: Launch

    var body: some View {
        List {
            Section(header: Text("Mission cores")) {
                if let coreInstances = launch.cores {
                    ForEach(coreInstances) { core in
                        VStack(alignment: .leading) {
                            Text(core.nameWithFlight)

                            Text(core.recoveryStatus)
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                }
            }

            if let rocket = launch.rocket {
                Section(header: Text("Vehicle")) {
                    VStack(alignment: .leading) {
                        Text(rocket.name ?? "Unknown model")
                            .font(.title)
                            .bold()
                        
                        Text("\(rocket.stageCountDescription) \(rocket.type ?? "vehicle")".uppercased())
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                            .font(.callout)
                    }
                    
                    Text("\(rocket.company ?? "Unknown manufacturer") (\(rocket.country ?? "Unknown country"))")
                }
                .padding(.vertical, 8)
                
                Section(header: Text("Physical specifications")) {
                    
                }
                
                Section(header: Text("Payload capabilities")) {
                    
                }
                
                Section(header: Text("Stages")) {
                    
                }
                
                Section(header: Text("Engines")) {
                    
                }
                
                // TODO: Images
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch.rocket?.name ?? "Rocket"))
    }
}

struct RocketSheet_Previews: PreviewProvider {
    static var previews: some View {
        RocketInstanceSheet(launch: FakeData.shared.trailblazer!)
    }
}
