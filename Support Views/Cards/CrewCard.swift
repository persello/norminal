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
    var crew: [Astronaut] {
        return launch.getCrew() ?? []
    }
    
    @State var modalPresented: Bool = false

    let spacing: CGFloat = 28
    let colsCount: Int = 5
    let size: CGFloat = 130

    var body: some View {
        let cols = Array(repeating: GridItem(.fixed(size), spacing: spacing), count: colsCount)
        Card(background: {
            ZStack(alignment: .top) {
                Color(UIColor.systemGray5)

                LazyVGrid(columns: cols) {
                    ForEach(0..<20) {
                        AstronautPicture(astronaut: crew[$0 % crew.count])
                            .frame(width: size, height: size)
                            .offset(x: (($0 / colsCount) % 2 == 0) ? 0 : size / 2 + spacing / 2)
                            .shadow(radius: 12)
                    }
                }
                .rotationEffect(.degrees(-24))

                Rectangle()
                    .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.7), .clear]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .frame(width: 1200, height: 240)
                    .clipped()

            }
            .drawingGroup()

        }, content: {
            CardOverlay(preamble: "Inside the Dragon", title: "Capsule Crew", bottomText: "Learn more", buttonText: "Open", buttonAction: {
                self.modalPresented = true
            })
        })
        .padding()
        .sheet(isPresented: $modalPresented, content: {
            CrewSheet(crew: crew, modalShown: self.$modalPresented)
        })

    }
}

struct CrewCard_Previews: PreviewProvider {
    static var previews: some View {
      CrewCard()
        .previewLayout(.sizeThatFits)
        .environmentObject(FakeData.shared.crewDragon!)
    }
}
