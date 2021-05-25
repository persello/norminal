//
//  LaunchDetailsSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import Foundation
import SwiftUI

struct LaunchDetailsSection: View {
    @EnvironmentObject var launch: Launch
    
    var body: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Group {
                    Text("Details")
                        .font(.title.bold())
                    
                    Text("Launch #\(launch.flightNumber) • \(launch.getNiceDate(usePrecision: true))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    if let sfDate = launch.staticFireDateUTC {
                        Text("Static fire on \(sfDate.localDescription)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                if let details = launch.details {
                    Divider().padding(.vertical, 8)
                    
                    Text(details)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .font(.system(.body, design: .serif))
                }
                
                if let success = launch.success {
                    Divider().padding(.vertical, 8)
                    
                    if success {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "checkmark.seal")
                                .foregroundColor(.green)
                            Text("Successful mission")
                        }
                    } else {
                        HStack {
                            Image(systemName: "xmark.seal")
                                .foregroundColor(.red)
                            Text("Failed mission")
                        }
                        
                        Divider().padding(.vertical, 8)
                        
                        if let failures = launch.failures {
                            ForEach(failures, id: \.self) { failure in
                                VStack(alignment: .leading) {
                                    Text(failure.reason?.capitalizingFirstLetter() ?? "Unknown reason")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .multilineTextAlignment(.leading)
                                    
                                    HStack {
                                        if let time = failure.time {
                                            Text("T\(time > 0 ? "+" : "")\(time) seconds")
                                        }
                                        if let altitude = failure.altitude {
                                            Text("(\(altitude) kilometers)")
                                        }
                                    }
                                    .foregroundColor(.gray)
                                }
                            }
                        }
                        
                        Divider().padding(.vertical, 8)
                    }
                }
                
                if !launch.upcoming {
                    if (launch.cores?.count ?? 0) != launch.coresToRecover {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "arrow.3.trianglepath")
                                .foregroundColor(.yellow)
                            if launch.coresToRecover == 0 {
                                Text("This booster is expendable")
                            } else {
                                Text("Some cores are expendable")
                            }
                        }
                    }
                    
                    switch launch.coresToRecover {
                        case 0:
                            EmptyView()
                        case 1:
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "arrow.3.trianglepath")
                                    .foregroundColor(launch.coresRecovered > 0 ? .green : .red)
                                Text("\(launch.coresRecovered > 0 ? "S" : "Uns")uccessful core recovery")
                            }
                        default:
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "arrow.3.trianglepath")
                                    .foregroundColor(launch.coresRecovered == launch.coresToRecover ? .green : .red)
                                Text("\(launch.coresRecovered) out of \(launch.coresToRecover) cores recovered")
                            }
                    }
                    
                    // Fairings
                    if launch.fairings?.recoveryAttempt ?? false {
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: (launch.fairings?.recovered ?? false) ? "checkmark.shield" : "xmark.shield")
                                .foregroundColor((launch.fairings?.recovered ?? false) ? .green : .red)
                            Text("Fairings \((launch.fairings?.recovered ?? false) ? "" : "not ")recovered")
                        }
                    }
                }
            }
            .padding(.init(top: 10, leading: 5, bottom: 15, trailing: 0))
        }
    }
}

struct LaunchDetailSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LaunchDetailsSection()
        }
        .environmentObject(FakeData.shared.trailblazer!)
    }
}
