//
//  PayloadNORADSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI

struct NORADListView: View {
    var ids: [String]
    var limit: Int?

    var body: some View {
        ForEach(0 ..< min(limit ?? ids.count, ids.count)) { idIndex in
            HStack {
                Text(ids[idIndex])
                    .font(.system(.body, design: .monospaced))
                Spacer()
                Link(destination:
                    URL(string: "https://www.n2yo.com/satellite/?s=\(ids[idIndex])")!,
                    label: {
                        Image(systemName: "safari")
                    })
            }
        }
    }
}

struct PayloadNORADSection: View {
    var ids: [Int]
    var stringIDs: [String] {
        ids.compactMap({ UsefulFormatters.plainNumberFormatter.string(for: $0) })
    }

    var body: some View {
        Section(header: Text("NORAD IDs")) {
            NORADListView(ids: stringIDs, limit: 6)
            if ids.count > 6 {
                NavigationLink(
                    destination: List {
                        NORADListView(ids: stringIDs, limit: nil)
                    }.navigationTitle("NORAD IDs").listStyle(InsetGroupedListStyle()),
                    label: {
                        Text("Other \(ids.count - 7) IDs")
                    })
            }
        }
        // For the minuscule "s"
        .textCase(nil)
    }
}

struct PayloadNORADSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                PayloadNORADSection(ids: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}
