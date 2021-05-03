//
//  PayloadCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 06/03/21.
//

import SwiftUI
import Telescope

struct PayloadCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false

    var payloadString: String {
        let payloads = launch.payloads
        let count = payloads?.count ?? 0
        if count == 0 {
            return "More information"
        } else if count == 1 {
            return "\(payloads?.first?.name ?? "Unknown payload")"
        } else {
            return "\(payloads?.first?.name ?? "Unknown payload") and \(count - 1) other\(count > 2 ? "s" : "")"
        }
    }

    var payloadTypeString: String {
        let payloads = launch.payloads
        let count = payloads?.count ?? 0
        let type = payloads?.first?.type

        if let t = type {
            if count == 1 {
                return ": " + t
            } else {
                return ": " + t + "s"
            }
        } else {
            return ""
        }
    }
    
    var imageName: String {
        if (launch.payloads?.first?.type?.lowercased() ?? "").contains("dragon") {
            return "dragon.space"
        } else {
            return "starlink.space"
        }
    }

    var body: some View {
        Card(background: {
            Image(imageName)
                .resizable()
                .scaledToFill()

        }, content: {
            CardOverlay(preamble: "Payload\(payloadTypeString)",
                        title: payloadString,
                        bottomText: "Read details",
                        buttonText: "Open",
                        buttonAction: {
                            self.modalPresented = true
                        })
        })
            .padding()
    }
}

struct PayloadCard_Previews: PreviewProvider {
    static var previews: some View {
        PayloadCard()
            .previewLayout(.fixed(width: 400, height: 500))
            .environmentObject(FakeData.shared.crewDragon!)
    }
}
