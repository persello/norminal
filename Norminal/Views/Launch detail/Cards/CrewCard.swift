//
//  CrewCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 26/10/2020.
//

import SwiftUI
import VisualEffects

struct CrewCard: View {
    @State var crew: [Astronaut]

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
                    .rotationEffect(.degrees(24))
                    .drawingGroup()

                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), .clear]),
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(width: 1200, height: 240)
                    .clipped()

            }

        }, content: {
            VStack(alignment: .leading, spacing: 8) {

                Text("Inside the Dragon".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)

                Text("Capsule Crew")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 12)

                Spacer()

                HStack {
                    Text("Learn more")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.label))
                    Spacer()
                    Button(action: { }, label: {
                        Text("Open")
                    })
                        .buttonStyle(RoundedButtonStyle())

                }
                    .padding(.vertical, 8)
                    .background(Rectangle().padding(-24).foregroundColor(Color(UIColor.systemGray6)))
            }
        })
            .padding()

    }
}

struct CrewCard_Previews: PreviewProvider {
    static var previews: some View {
        CrewCard(crew: [FakeData.shared.robertBehnken!])
    }
}
