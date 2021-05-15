//
//  RocketSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 13/05/21.
//

import SwiftUI

struct RocketSheet: View {
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
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(rocket.company ?? "Unknown manufacturer")

                        }
                        Text(rocket.country ?? "Unknown country")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
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
        RocketSheet(launch: FakeData.shared.trailblazer!)
    }
}
