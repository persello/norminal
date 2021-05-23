//
//  CoreListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct CoreListTile: View {
    var core: Core
    var body: some View {
        HStack {
            Group {
                if let reuseCount = core.reuseCount,
                   reuseCount > 0 {
                    Text("\(reuseCount)")
                        .font(.caption)
                        .bold()
                        .padding(.top, 2)
                } else {
                    Text(" ")
                }
            }
            .background(
                Image(systemName: "arrow.3.trianglepath")
                    .font(Font.largeTitle.weight(.light))
            )
            .padding()
            .foregroundColor(core.landings > 0 ? .green : core.launches.filter({ !$0.upcoming }).count > 0 ? .red : .lightGray)

            VStack(alignment: .leading) {
                HStack {
                    Text(core.serial)
                        .bold()
                        .foregroundColor((core.status == .active || core.status == .unknown) ? .primary : .gray)

                    let status = core.status
                    if status != .unknown {
                        Text(status.rawValue.capitalizingFirstLetter())
                            .foregroundColor(status == .expended ? .yellow : status == .lost ? .red : .lightGray)
                            .bold()
                    }
                }

                if let block = core.block {
                    Text("Block \(block)")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct CoreListTile_Previews: PreviewProvider {
    static var previews: some View {
        CoreListTile(core: FakeData.shared.b1051!)
            .previewLayout(.sizeThatFits)
    }
}
