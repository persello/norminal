//
//  RocketModelSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 17/05/21.
//

import SwiftUI
import Telescope

struct RocketModelSection: View {
    var rocket: Rocket
    @State var galleryModalPresented: Bool = false

    var body: some View {
        Section(header: Text("Vehicle")) {
            ZStack(alignment: .topLeading) {
                if let imageURL = rocket.flickrImages?.first {
                    TImage(RemoteImage(imageURL: imageURL))
                        .resizable()
                        .scaledToFill()
                        .padding(.vertical, -6)
                }

                if let imageURLs = rocket.flickrImages {
                    Button(action: { galleryModalPresented.toggle() }, label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .foregroundColor(.white)
                    })
                        .frame(width: 40, height: 40, alignment: .leading)
                        .shadow(radius: 4)
                        .sheet(isPresented: $galleryModalPresented, content: {
                            RootSheet(modalShown: $galleryModalPresented) { GallerySheet(imageURLs: imageURLs) }
                        })
                }
            }

            VStack(alignment: .leading) {
                Text(rocket.name ?? "Unknown model")
                    .font(.title)
                    .bold()

                Text("\(rocket.stageCountDescription) \(rocket.type ?? "vehicle")\((rocket.boosters ?? 0) > 0 ? " with \(rocket.boosters!) boosters" : "")".uppercased())
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                    .font(.callout)

                if let legsCount = rocket.landingLegsCount {
                    Text("\(legsCount) \(rocket.landingLegsMaterial ?? "") landing legs".uppercased())
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }

                if let desc = rocket.description {
                    Text(desc)
                        .padding(.top, 4)
                        .font(.system(.body, design: .serif))
                }
            }
            .padding(.bottom)
            .padding(.top, 4)

            if let wikipedia = rocket.wikipedia {
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
                            .foregroundColor(.black)
                    }
                }
            }

            if let manufacturer = rocket.company {
                InformationRow(label: "Manufacturer", value: manufacturer, imageName: "wrench.and.screwdriver")
            }

            if let country = rocket.country {
                InformationRow(label: "Country", value: country, imageName: "flag")
            }

            if let cost = rocket.costPerLaunch {
                InformationRow(label: "Launch cost", value: UsefulFormatters.dollarsFormatter.string(from: cost as NSNumber), imageName: "dollarsign.square")
            }

            if let successRate = rocket.successRate {
                InformationRow(label: "Success rate", value: UsefulFormatters.percentageFormatter.string(from: successRate / 100 as NSNumber), imageName: "checkmark.square")
            }
        }
    }
}

struct RocketModelSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            RocketModelSection(rocket: FakeData.shared.falcon9!)
        }
        .listStyle(InsetGroupedListStyle())
    }
}
