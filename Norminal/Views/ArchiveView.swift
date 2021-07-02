//
//  ArchiveView.swift
//  Norminal
//
//  Created by Riccardo Persello on 22/05/21.
//

import SwiftUI
import Telescope

struct ArchiveCard<Destination: View>: View {
    var title: String
    var imageURL: URL? = nil
    var image: Image? = nil
    var destination: Destination

    @State var navigationActive: Bool = false

    var body: some View {
        NavigationLink(destination: destination, isActive: $navigationActive) {
            Card(background: {
                GeometryReader { geometry in
                    Group {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if let imageURL = imageURL {
                            TImage(RemoteImage(imageURL: imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                        } else {
                            EmptyView()
                        }
                    }
                    .padding(.top, -30 - geometry.frame(in: .global).minY / 20)
                    .padding(.bottom, -30 + geometry.frame(in: .global).minY / 20)
                }
            }, content: {
                Text(title)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
            },
            aspectRatio: 1.618,
            bottomBackgroundPadding: 0,
            onTap: {
                navigationActive = true
            })
        }
    }
}

struct ArchiveView: View {

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 28) {
                    ArchiveCard(title: "Astronauts",
                                image: Image("dragon.human.photo"),
                                destination: AstronautListView(astronauts: globalData.crew))

                    ArchiveCard(title: "Starlink",
                                image: Image("starlink.space"),
                                destination: StarlinkListView(starlinks: globalData.starlinks))

                    ArchiveCard(title: "Cores",
                                imageURL: FakeData.shared.falcon9?.flickrImages?[3],
                                destination: CoreListView(cores: globalData.cores))

                    ArchiveCard(title: "Capsules",
                                imageURL: FakeData.shared.dragon2?.flickrImages?[1],
                                destination: CapsuleListView(capsules: globalData.capsules))

                    ArchiveCard(title: "Payloads",
                                imageURL: FakeData.shared.dragon2?.flickrImages?[2],
                                destination: PayloadListView(payloads: globalData.payloads))

                    ArchiveCard(title: "Ships",
                                imageURL: FakeData.shared.ocisly?.image,
                                destination: ShipListView(ships: globalData.ships))

                    ArchiveCard(title: "Vehicles",
                                image: Image("starship.marslanding.render"),
                                destination: VehicleListView(rockets: globalData.rockets))

                    ArchiveCard(title: "Pads",
                                imageURL: FakeData.shared.falcon9?.flickrImages?[1],
                                destination: PadListView(launchpads: globalData.launchpads,
                                                         landpads: globalData.landpads))

                    ArchiveCard(title: "Company",
                                image: Image("rocket.generic"),
                                destination: CompanySheet(company: globalData.companyInfo, history: globalData.history))

                    ArchiveCard(title: "About",
                                image: Image("norminal.code"),
                                destination: AboutView())
                }
                .padding()
            }
            .navigationTitle(Text("Archive"))
        }
    }
}

struct ArchiveView_Previews: PreviewProvider {
    static var previews: some View {
        ArchiveView()
            .environmentObject(SpaceXData.shared)
    }
}
