//
//  RocketCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/03/21.
//

import SwiftUI

struct RocketCard: View {
  @State var launch: Launch
  @State var modalPresented: Bool = false
  
  var body: some View {
    Card(background: {
      Image("starship.render")
        .resizable()
        .scaledToFill()
      
    }, content: {
      CardOverlay(preamble: "Vehicle",
                  title: "**MOCKUP**",
                  bottomText: "Read details",
                  buttonText: "Open",
                  buttonAction: {
                    self.modalPresented = true
                  })
    })
    .padding()
  }
}


struct RocketCard_Previews: PreviewProvider {
  static var previews: some View {
    RocketCard(launch: FakeData.shared.crewDragon!)
      .previewLayout(.sizeThatFits)
  }
}
