//
//  HistoryEntryTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct HistoryEntryTile: View {
    var title: String
    var details: String?
    var date: Date?
    var link: URL?

    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Circle()
                    .foregroundColor(.background)
                    .frame(width: 24, height: 24, alignment: .center)
                    .padding(4)
                    .background(Circle().foregroundColor(.accentColor))
                    .padding(10)
                Rectangle()
                    .frame(maxWidth: 4, maxHeight: .infinity, alignment: .center)
                    .foregroundColor(.accentColor)
            }
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .bold()
                
                if let date = date {
                    Text(UsefulFormatters.shortDateFormatter.string(from: date))
                        .foregroundColor(.gray)
                }

                if let details = details {
                    Text(details)
                        .lineLimit(.none)
                        .font(.system(.body, design: .serif))
                        .padding(.vertical, 8)
                }

                if let link = link {
                    Link(destination: link, label: {
                        Label("Article", systemImage: "newspaper")
                    })
                    .padding(.vertical)
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
        }
    }
}

struct HistoryEntryTile_Previews: PreviewProvider {
    static var previews: some View {
        HistoryEntryTile(title: "Title of the event, quite long", details: "Details, details, details, details, details... More details details, details...", date: Date(), link: URL(string: "https://persello.tk"))
            .previewLayout(.sizeThatFits)
    }
}
