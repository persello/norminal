//
//  LandpadHeaderSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct LandpadHeaderSection: View {
    @EnvironmentObject var landpad: Landpad
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(landpad.fullName.capitalizingFirstLetter())
                    .font(.title)
                    .bold()

                Text("\(landpad.locality), \(landpad.region) • \(landpad.type)".uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)
                
                if let details = landpad.details {
                    Text(details)
                        .padding(.top, 4)
                        .font(.system(.body, design: .serif))
                }
            }
            .padding(.vertical, 4)
            
            if let wikipedia = landpad.wikipedia {
                Button(action: {
                    UIApplication.shared.open(wikipedia)
                }) {
                    HStack {
                        Image("wikipedia.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .frame(width: 28, height: 28, alignment: .center)
                                    .foregroundColor(.white)
                            )
                        
                        Text("Wikipedia")
                            .foregroundColor(.primary)
                    }
                }
            }

            InformationRow(label: "Landings", value: "\(landpad.landingSuccesses)/\(landpad.landingAttempts)", imageName: "arrow.down.to.line")
            
            InformationRow(label: "Status", value: "\(landpad.status)".capitalizingFirstLetter(), imageName: "questionmark")
        }
    }
}

struct LandpadHeaderSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LandpadHeaderSection()
        }
        .environmentObject(FakeData.shared.lz1!)
        .listStyle(InsetGroupedListStyle())
    }
}
