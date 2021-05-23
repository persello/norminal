//
//  ShipDetailsSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI
import Telescope

struct ShipDetailsSection: View {
    @EnvironmentObject var ship: Ship

    var body: some View {
        Section {
            if let imageURL = ship.image {
                TImage(RemoteImage(imageURL: imageURL))
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, -6)
            }

            VStack(alignment: .leading) {
                Text(ship.name.capitalizingFirstLetter())
                    .font(.title2)
                    .bold()

                Text("\(ship.model ?? "Unknown model") • \(ship.type ?? "Ship")".uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)
            }
            .padding(.vertical, 4)

            Group {
                InformationRow(label: "Active", value: ship.active ? "Yes" : "No", imageName: "gear")

                if let roles = ship.roles,
                   roles.count > 0 {
                    InformationRow(label: "Roles", value: ListFormatter().string(from: roles), imageName: "person.crop.square.fill.and.at.rectangle")
                }

                if let imo = ship.imo {
                    InformationRow(label: "IMO", value: "\(imo)", imageName: "location.viewfinder", isSerial: true)
                }

                if let mmsi = ship.mmsi {
                    InformationRow(label: "MMSI", value: "\(mmsi)", imageName: "location.viewfinder", isSerial: true)
                }

                if let mass = ship.mass {
                    InformationRow(label: "Mass", value: UsefulFormatters.measurementFormatter.string(from: mass), imageName: "scalemass")
                }

                if let year = ship.constructionYear {
                    InformationRow(label: "Construction year", value: "\(year)", imageName: "calendar")
                }

                if let homeport = ship.homePort {
                    InformationRow(label: "Home port", value: homeport, imageName: "house")
                }

                if let status = ship.status,
                   status.count > 0 {
                    InformationRow(label: "Status", value: status, imageName: "newspaper")
                }

                if let link = ship.link {
                    Link(destination: link) {
                        Label(
                            title: { Text("View on Marinetraffic") },
                            icon: { Image(systemName: "link") }
                        )
                    }
                }
            }
        }
    }
}

struct ShipDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ShipDetailsSection()
        }
        .environmentObject(FakeData.shared.ocisly!)
        .listStyle(InsetGroupedListStyle())
    }
}
