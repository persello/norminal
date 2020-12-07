//
//  WebcastSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/11/2020.
//

import SwiftUI
import XCDYouTubeKit
import AVKit
import VisualEffects

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

struct WebcastSheet: View {
    var launch: Launch
    @Binding var modalShown: Bool
    
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    
    @State private var player: AVPlayer? = nil
    
    func getYoutubeLink() {
        XCDYouTubeClient.default().getVideoWithIdentifier(launch.links?.youtubeID!) { (video, error) in
            guard video != nil else {
                // Handle error
                return
            }
            //Do something with video
            let link = video?.streamURLs[YouTubeVideoQuality.medium360]
            if let l = link {
                player = AVPlayer(url: l)
                player?.automaticallyWaitsToMinimizeStalling = true
                player?.allowsExternalPlayback = true
                
                // Override silent switch
                try! AVAudioSession.sharedInstance().setCategory(.playback)
                
                // Push video title to "Now playing" info
                var videoInfo = [String : Any]()
                videoInfo[MPMediaItemPropertyTitle] = video?.title
                
                MPNowPlayingInfoCenter.default().nowPlayingInfo = videoInfo
            }
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            Color(UIColor.systemGray6)
                .ignoresSafeArea(edges: .all)
                .overlay(
                    VStack {
                        if let p = self.player {
                            VideoPlayer(player: p)
                                .aspectRatio(16/9, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding()
                                .onAppear(perform: {
                                    self.player?.play()
                                })
                        } else {
                            ProgressView()
                                .padding()
                        }
                        List {
                            Section {
                                
                            }
                            Section {
                                Link(destination: (launch.links?.webcast)!, label: {
                                    Label("Watch on YouTube", systemImage: "play.rectangle.fill")
                                })
                            }
                        }
                        .listStyle(InsetGroupedListStyle())
                        Spacer()
                    }
                    .navigationBarTitle(Text("Launch webcast"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        self.modalShown.toggle()
                    }) {
                        Text("Done").bold()
                    })
                    .onAppear(perform: {
                        self.getYoutubeLink()
                    })
                )
        }
    }
}

struct WebcastSheet_Previews: PreviewProvider {
    static var previews: some View {
        WebcastSheet(launch: FakeData.shared.crewDragon!, modalShown: .constant(true))
    }
}
