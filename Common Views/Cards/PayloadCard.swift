//
//  PayloadCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 06/03/21.
//

import SwiftUI

struct PayloadCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false
    
    var body: some View {
        Card(background: {
            Image("dragon.render")
                .resizable()
                .scaledToFill()
            
        }, content: {
            CardOverlay(preamble: "Payload",
                        title: "**MOCKUP**",
                        bottomText: "Read details",
                        buttonText: "Open",
                        buttonAction: {
                            self.modalPresented = true
                        })
        })
        .padding()    }
}

struct PayloadCard_Previews: PreviewProvider {
    static var previews: some View {
        PayloadCard()
            .previewLayout(.sizeThatFits)
            .environmentObject(FakeData.shared.crewDragon!)
    }
}
