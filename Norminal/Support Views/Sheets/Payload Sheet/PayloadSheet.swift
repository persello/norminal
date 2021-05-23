//
//  PayloadSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI
import Telescope

struct PayloadSheet: View {
    var payloads: [Payload]

    var title: String {
        if payloads.count == 1 {
            if let name = payloads.first?.name {
                return name
            }
            return "Payload"
        }
        return "Payloads"
    }

    var body: some View {
        if payloads.count == 1 {
            SinglePayloadSheet(payload: payloads.first!)
        } else {
            List {
                ForEach(payloads, id: \.stringID) { payload in
                    NavigationLink(destination: SinglePayloadSheet(payload: payload)) {
                        PayloadListTile(payload: payload, showPatch: false)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(title)
        }
    }
}

struct PayloadSheet_Previews: PreviewProvider {
    static var previews: some View {
        PayloadSheet(payloads: [FakeData.shared.starlink22Payload!, FakeData.shared.crew2Payload!])
    }
}
