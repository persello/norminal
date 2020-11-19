//
//  WebcastCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 14/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebcastCard: View {
    @State var launch: Launch
    @State var modalPresented: Bool = false
    
    var body: some View {
        Card(background: {
            WebImage(url: URL(string: "https://img.youtube.com/vi/\((launch.links?.youtubeID)!)/maxresdefault.jpg"))
                .resizable()
                .indicator(Indicator.activity(style: .large))
                .aspectRatio(contentMode: .fill)
        }, content: {
            CardOverlay(preamble: "Did it land?", title: "Webcast", bottomText: "Watch now", buttonText: "Open", buttonAction: {
                self.modalPresented = true
            })
        })
        .padding()
        .sheet(isPresented: $modalPresented, content: {
            WebcastSheet(modalShown: self.$modalPresented)
        })
    }
}

struct WebcastCard_Previews: PreviewProvider {
    static var previews: some View {

        VStack {
            WebcastCard(launch: FakeData.shared.crewDragon!)
        }
    }
}
