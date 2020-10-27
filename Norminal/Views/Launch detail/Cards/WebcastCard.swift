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
    var body: some View {
        Card(background: {
            WebImage(url: URL(string: "https://img.youtube.com/vi/\((launch.links?.youtubeID)!)/maxresdefault.jpg"))
                .resizable()
                .indicator(Indicator.activity(style: .large))
                .aspectRatio(contentMode: .fill)
        }, content: {
            VStack(alignment: .leading, spacing: 8) {
                Text("Did it land?".uppercased())
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                Text("SpaceX Webcast")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 12)
                Spacer()
                HStack {
                    Text("Watch it now")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.label))
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Open")
                    })
                    .buttonStyle(RoundedButtonStyle())
                    
                }
                .padding(.vertical, 8)
                .background(Rectangle().padding(-24).foregroundColor(Color(UIColor.systemGray6)))
            }
        })
        .padding()
    }
}

struct WebcastCard_Previews: PreviewProvider {
    static var previews: some View {
        
        VStack {
            WebcastCard(launch: FakeData.shared.crewDragon!)
        }
    }
}
