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
    @EnvironmentObject private var globalData: SpaceXData

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 28) {
                    ArchiveCard(title: "Astronauts",
                                image: Image("dragon.human.photo"),
                                destination: CrewSheet(crew: globalData.crew))
                    
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
                                destination: PayloadSheet(payloads: globalData.payloads, showPatches: true))
                    
                    ArchiveCard(title: "Ships",
                                imageURL: FakeData.shared.ocisly?.image,
                                destination: EmptyView())
                    
                    ArchiveCard(title: "Vehicles",
                                image: Image("starship.marslanding.render"),
                                destination: EmptyView())
                    
                    ArchiveCard(title: "Pads",
                                imageURL: FakeData.shared.falcon9?.flickrImages?[1],
                                destination: EmptyView())
                    
                    ArchiveCard(title: "Company",
                                image: nil,
                                destination: EmptyView())
                    
                    ArchiveCard(title: "About",
                                image: nil,
                                destination: EmptyView())
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
