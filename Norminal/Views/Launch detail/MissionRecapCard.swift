//
//  MissionRecapCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 11/10/2020.
//

import SwiftUI
import VisualEffects
import SDWebImageSwiftUI

struct MissionRecapCard: View {
    @State var launch: Launch

    var body: some View {
        ZStack {
            VisualEffectBlur(blurStyle: .systemThinMaterial, vibrancyStyle: .label) {

                HStack(alignment: .center, spacing: 8) {
                    WebImage(url: launch.links?.patch?.large)
                        .resizable()
                        .indicator(Indicator.activity)
                        .frame(width: 70, height: 70)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(launch.name)
                            .multilineTextAlignment(.leading)
                            .font(.headline)

                        HStack(alignment: .center, spacing: 6) {
                            if launch.success == true {
                                Text("\(Image(systemName: "checkmark.seal.fill")) Success")
                                    .font(.caption)
                                    .foregroundColor(.green)
                            } else if launch.success == false {
                                Text("\(Image(systemName: "xmark.seal.fill")) Failure")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            Text("Launch #\(launch.flightNumber)")
                                .font(.caption)
                                .opacity(0.8)
                        }

                        Text((launch.getNiceDate(usePrecision: true)).uppercased())
                            .font(.caption)
                    }
                        .padding(8)
                }
            }
                .frame(height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        }
    }
}

struct MissionRecapCard_Previews: PreviewProvider {
    static var previews: some View {
        MissionRecapCard(launch: FakeData.shared.crewDragon!)
            .previewLayout(.sizeThatFits)
            .padding()

    }
}
