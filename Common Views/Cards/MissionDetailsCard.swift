//
//  MissionDetailsCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/03/21.
//

import SwiftUI

struct MissionDetailsCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false

    let defaultText = """
    This mission doesn't have any details. It's reasonable to think that a rocket will take something or someone to space, but we still don't know any details about that. Maybe a flight to the ISS? Or an ambitious trip to Mars? Another Roadster in space? Or a Starship test flight? Who knows? I think you'll need to wait a bit more.
    """

    var body: some View {
        Card(background: {
            Text(launch.details ?? defaultText)
                .shadow(color: .black, radius: 3, x: 5, y: 3)
                .foregroundColor(Color(.label.withAlphaComponent(0.45)))
                .multilineTextAlignment(.center)
                .font(.system(size: 32, weight: .semibold, design: .serif))
                .drawingGroup()
                .scaleEffect(CGSize(width: 2.0, height: 2.0))
                .rotationEffect(Angle(degrees: 24))

        }, content: {
            CardOverlay(preamble: "All about \(launch.name)",
                        title: "Mission details",
                        bottomText: "Read more",
                        buttonText: "Open",
                        buttonAction: {
                            self.modalPresented = true
                        })
        })
            .padding()
            .sheet(isPresented: $modalPresented, content: {
                RootSheet(modalShown: $modalPresented) { DetailsSheet(launch: launch) }
            })
    }
}

struct MissionDetailsCard_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MissionDetailsCard()
                .preferredColorScheme(.light)
            MissionDetailsCard()
                .preferredColorScheme(.dark)
        }
        .environmentObject(FakeData.shared.crewDragon!)
        .previewLayout(.fixed(width: 400, height: 500))
    }
}
