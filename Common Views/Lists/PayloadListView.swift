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
        Group {
            if payloads.count > 0 {
                List {
                    ForEach(payloads) { payload in
                        NavigationLink(destination: SinglePayloadSheet(payload: payload)) {
                            PayloadListTile(payload: payload, showPatch: true)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "shippingbox")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No payloads available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Payloads"))
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
