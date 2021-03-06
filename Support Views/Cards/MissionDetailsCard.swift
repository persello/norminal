//
//  MissionDetailsCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/03/21.
//

import SwiftUI

struct MissionDetailsCard: View {
  @State var launch: Launch
  @State var modalPresented: Bool = false
  
  var body: some View {
    Card(background: {
      ZStack(alignment: .top) {
        Text(launch.details ?? "")
          .shadow(color: .black, radius: 3, x: 5, y: 3)
          .foregroundColor(Color(UIColor.label.withAlphaComponent(0.45)))
          .multilineTextAlignment(.center)
          .font(.system(size: 32, weight: .semibold, design: .serif))
          .scaleEffect(CGSize(width: 2.0, height: 2.0))
          .rotationEffect(Angle(degrees: 24))

        Rectangle()
          .fill(LinearGradient(
                  gradient: Gradient(colors: [Color.black.opacity(0.6), .clear]),
                  startPoint: .top,
                  endPoint: .center))
          .scaledToFill()
          .clipped()
      }
      .drawingGroup()

    }, content: {
      CardOverlay(preamble: "All about \(launch.name)",
                  title: "**MOCKUP**",
                  bottomText: "Read more",
                  buttonText: "Open",
                  buttonAction: {
                    self.modalPresented = true
                  })
    })
    .padding()
  }
}

struct MissionDetailsCard_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      MissionDetailsCard(launch: FakeData.shared.crewDragon!)
        .preferredColorScheme(.light)
        .previewLayout(.sizeThatFits)
      MissionDetailsCard(launch: FakeData.shared.crewDragon!)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}
