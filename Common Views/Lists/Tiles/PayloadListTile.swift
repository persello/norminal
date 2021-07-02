//
//  PayloadListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct PayloadListTile: View {
    var payload: Payload
    var showPatch: Bool = false
    @State var launch: Launch?

    var body: some View {
        HStack {
            if showPatch {
                if let patch = launch?.getPatch() {
                    TImage(patch)
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .center)
                } else {
                    Image(systemName: "seal")
                        .frame(width: 24, height: 24, alignment: .center)
                        .foregroundColor(.gray)
                        .onAppear {
                            payload.getLaunch { launch in
                                self.launch = launch
                            }
                        }
                }
            }

            VStack(alignment: .leading) {
                Text(payload.name ?? "Unknown payload")
                    .bold()

                Text(payload.type?.uppercased() ?? "")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
    }
}

struct PayloadListTile_Previews: PreviewProvider {
    static var previews: some View {
        PayloadListTile(payload: FakeData.shared.crew2Payload!, showPatch: true)
    }
}
