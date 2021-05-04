//
//  CrewCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/10/2020.
//

import SwiftUI
import VisualEffects

struct CrewCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false
    
    var crew: [Astronaut] {
        return launch.crew ?? []
    }

    let spacing: CGFloat = 28
    let size: CGFloat = 130
    
    let cols: [GridItem] = [
        GridItem(.adaptive(minimum: 100, maximum: 200))
    ]

    var body: some View {
        Card(background: {
            LazyVGrid(columns: cols) {
                ForEach(crew) { astronaut in
                    AstronautPicture(astronaut: astronaut)
                        .padding()
                        .scaledToFit()
                        .shadow(radius: 12)
                }
            }
            .padding(.horizontal, 30)
        }, content: {
            CardOverlay(preamble: "Inside the Dragon", title: "Capsule Crew", bottomText: "Learn more", buttonText: "Open", buttonAction: {
                self.modalPresented = true
            })
        })
        .padding()
        .sheet(isPresented: $modalPresented, content: {
            RootSheet(content: CrewSheet(crew: crew), modalShown: $modalPresented)
        })
    }
}

struct CrewCard_Previews: PreviewProvider {
    static var previews: some View {
      CrewCard()
        .environmentObject(FakeData.shared.crewDragon!)
        .frame(width: 400, height: 500, alignment: .center)
        .previewLayout(.sizeThatFits)
        .padding(48)
    }
}
