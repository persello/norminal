//
//  RocketCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/03/21.
//

import SwiftUI
import Telescope

struct RocketCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false
    @State var rocket: Rocket?

    var imageName: String {
        let name = rocket?.name ?? ""
        if name.lowercased().contains("falcon 9") {
            return "f9.fairings.render"
        } else if name.lowercased().contains("falcon heavy") {
            return "fh.fairings.render"
        } else if name.lowercased().contains("starship") {
            return "starship.stack.render"
        } else {
            return "rocket.generic"
        }
    }

    var body: some View {
        Card(background: {
            if let imageURL = rocket?.flickrImages?.first {
                TImage(RemoteImage(imageURL: imageURL))
                    .resizable()
                    .scaledToFill()
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
            }

        }, content: {
            CardOverlay(preamble: "Vehicle",
                        title: rocket?.name ?? "Rocket",
                        bottomText: "Read details",
                        buttonText: "Open",
                        buttonAction: {
                            self.modalPresented = true
                        })
        })
            .padding()
            .sheet(isPresented: $modalPresented, content: {
                RootSheet(modalShown: $modalPresented) {
                    RocketSheet(launch: launch)
                }
            })
        .onAppear {
            launch.getRocket {rocket in
                self.rocket = rocket
            }
        }
    }
}

struct RocketCard_Previews: PreviewProvider {
    static var previews: some View {
        RocketCard()
            .previewLayout(.sizeThatFits)
            .environmentObject(FakeData.shared.crewDragon!)
    }
}
