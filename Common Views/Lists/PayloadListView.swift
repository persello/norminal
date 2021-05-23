//
//  PayloadListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct PayloadListView: View {
    var payloads: [Payload]

    var body: some View {
        List {
            ForEach(payloads) { payload in
                NavigationLink(destination: SinglePayloadSheet(payload: payload)) {
                    PayloadListTile(payload: payload, showPatch: true)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct PayloadListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PayloadListView(payloads: [FakeData.shared.crew2Payload!,
                                       FakeData.shared.roadsterPayload!,
                                       FakeData.shared.starlink22Payload!])
        }
    }
}
