//
//  MissionRecapView.swift
//  Norminal
//
//  Created by Riccardo Persello on 11/10/2020.
//

import SwiftUI
import Telescope
import VisualEffects

struct MissionRecapView: View {
    @EnvironmentObject var launch: Launch
    var showCrewWhenAvailable: Bool = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            TImage(try? RemoteImage(stringURL: launch.links?.patch?.large?.absoluteString ?? ""))
                .resizable()
                .placeholder {
                    Image(systemName: "xmark.seal")
                        .foregroundColor(.gray)
                        .font(.system(size: 40, weight: .thin))
                        .frame(width: 70, height: 70)
                        .background(Circle().foregroundColor(Color(.systemGray6)))
                }
                .frame(width: 70, height: 70)
                .padding(4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(launch.name)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                
                HStack(alignment: .center, spacing: 6) {
                    
                    // Number
                    Text("#\(launch.flightNumber)")
                        .font(.system(.caption, design: .monospaced))
                        .opacity(0.8)
                    
                    // Success
                    // == true/false is for excluding nil
                    if launch.success == true {
                        Text("\(Image(systemName: "checkmark.seal.fill")) Success")
                            .foregroundColor(.green)
                    } else if launch.success == false {
                        Text("\(Image(systemName: "xmark.seal.fill")) Failure")
                            .foregroundColor(.red)
                    }
                    
                    // Cores
                    if !launch.upcoming {
                        switch launch.coresToRecover {
                            case 0:
                                EmptyView()
                            case 1:
                                Text("\(Image(systemName: "arrow.3.trianglepath"))")
                                    .foregroundColor(launch.coresRecovered > 0 ? .blue : .red)
                            default:
                                Text("\(Image(systemName: "arrow.3.trianglepath")) \(launch.coresRecovered)/\(launch.coresToRecover)")
                                    .foregroundColor(launch.coresRecovered == launch.coresToRecover ? .blue : .red)
                        }
                        
                        // Fairings
                        if launch.fairings?.recoveryAttempt ?? false {
                            Image(systemName: (launch.fairings?.recovered ?? false) ? "checkmark.shield" : "xmark.shield")
                                .foregroundColor((launch.fairings?.recovered ?? false) ? .blue : .red)
                        }
                    }
                }
                .font(.caption)
                
                HStack(spacing: 4) {
                    Text(launch.getNiceDate(usePrecision: true) + (launch.NET ? "NET" : ""))
                    
                    if let rocketName = launch.rocket?.name {
                        Text("•")
                            .foregroundColor(.secondary)
                        
                        Text(rocketName)
                            .foregroundColor(.secondary)
                    }
                }
                .font(.caption)

                
                // Crew
                if let crew = launch.crew, showCrewWhenAvailable {
                    HStack {
                        ForEach(crew) { astronaut in
                            AstronautPicture(astronaut: astronaut)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(8)
        }
    }
}

struct MissionRecapView_Previews: PreviewProvider {
    static var previews: some View {
        MissionRecapView(showCrewWhenAvailable: true)
            .previewLayout(.sizeThatFits)
            .environmentObject(FakeData.shared.crewDragon!)
    }
}
