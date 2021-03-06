//
//  WebcastCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 14/10/2020.
//

import SwiftUI
import Telescope
import XCDYouTubeKit

struct WebcastCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false
    @State var thumbnailLink: URL?

    func getYoutubeThumbnailLink() {
        XCDYouTubeClient.default().getVideoWithIdentifier(launch.links?.youtubeID!) { video, _ in
            guard video != nil else {
                // Handle error
                return
            }

            // Do something with video
            if let c = video?.thumbnailURLs?.count {
                if let l = video?.thumbnailURLs?[c - 1] {
                    thumbnailLink = l
                }
            }
        }
    }

    var body: some View {
        Card(background: {
            if thumbnailLink != nil {
                TImage(RemoteImage(imageURL: thumbnailLink!))
                    .resizable()
                    .placeholder({
                        Color(.systemGray5)
                            .overlay(
                                VStack {
                                    Spacer()
                                    ProgressView()
                                    Spacer()
                                })

                    })
                    .scaledToFill()
            }
        }, content: {
            CardOverlay(preamble: "Did it land?", title: "Webcast", bottomText: "Watch now", buttonText: "Open", buttonAction: {
                self.modalPresented = true
            })
        })
            .padding()
            .sheet(isPresented: $modalPresented, content: {
                RootSheet(modalShown: $modalPresented) { WebcastSheet(videoID: (launch.links?.youtubeID)!) }
            })
            .onAppear {
                getYoutubeThumbnailLink()
            }
    }
}

struct WebcastCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WebcastCard()
        }
        .previewLayout(.sizeThatFits)
        .environmentObject(FakeData.shared.crewDragon!)
    }
}
