//
//  WebcastSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/11/2020.
//

import SwiftUI
import XCDYouTubeKit
import AVKit
import SDWebImageSwiftUI

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

struct SmallWebcastPreviewView: View {
    var video: XCDYouTubeVideo
    
    var body: some View {
        HStack {
            WebImage(url: video.thumbnailURLs?.first)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                .padding(.leading, -10)
            
            VStack(alignment: .leading) {
                if let splitted = video.title.split(separator: "|") {
                    Text(splitted.first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Webcast")
                    
                    if splitted.count > 1 {
                        Text(splitted.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "Details")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct WebcastSheet: View {
    var videoID: String
    @Binding var modalShown: Bool
    
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    
    @State private var player: AVPlayer?
    @State private var thumbnailURL: URL?
    
    @State private var interestingVideos: [XCDYouTubeVideo] = []
    
    func getThumbnail() {
        XCDYouTubeClient.default().getVideoWithIdentifier(videoID) { (video, _) in
            guard video != nil else {
                return
            }
            
            if let url = video?.thumbnailURLs?.last {
                thumbnailURL = url
            }
        }
    }
    
    func analyzeYouTubeDescription() {
        XCDYouTubeClient.default().getVideoWithIdentifier(videoID) { (video, _) in
            guard video != nil else {
                return
            }
            
            if let description = video?.videoDescription {
                let types: NSTextCheckingResult.CheckingType = .link
                
                if let detector = try? NSDataDetector(types: types.rawValue) {
                    
                    let matches = detector.matches(in: description, options: .reportCompletion, range: NSMakeRange(0, description.count))
                    
                    let strings = matches.compactMap({$0.url?.description})
                    let ids = strings.compactMap({$0.split(separator: "/").last?.description})
                    
                    for id in ids {
                        XCDYouTubeClient.default().getVideoWithIdentifier(id) { (video, _)  in
                            guard video != nil else {
                                return
                            }
                            
                            interestingVideos.append(video!)
                        }
                    }
                }
            }
        }
    }
    
    func getYouTubeLink() {
        XCDYouTubeClient.default().getVideoWithIdentifier(videoID) { (video, _) in
            guard video != nil else {
                // Handle error
                return
            }
            
            //Do something with video
            let link = video?.streamURLs[YouTubeVideoQuality.medium360]
            if let link = link {
                player = AVPlayer(url: link)
                player?.automaticallyWaitsToMinimizeStalling = true
                player?.allowsExternalPlayback = true
                
                // Override silent switch
                // swiftlint:disable force_try
                try! AVAudioSession.sharedInstance().setCategory(.playback)
                
                // Push video title to "Now playing" info
                var videoInfo = [String: Any]()
                videoInfo[MPMediaItemPropertyTitle] = video?.title
                
                MPNowPlayingInfoCenter.default().nowPlayingInfo = videoInfo
            }
        }
    }
    
    var body: some View {
        NavigationView {
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
                    
                    ZStack {
                        if let url = thumbnailURL {
                            // Thumbnail preview
                            WebImage(url: url)
                                .resizable()
                                .aspectRatio(16/9, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding()
                            
                        } else {
                            // Gray rectangle
                            Rectangle()
                                .fill(Color(UIColor.systemGray6))
                                .aspectRatio(16/9, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .padding()
                        }
                        
                        ProgressView()
                    }
                }
                
                List {
                    if let YouTubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)") {
                        Section {
                            Link(destination: YouTubeURL, label: {
                                Label("Watch on YouTube", systemImage: "play.rectangle.fill")
                            })
                        }
                    }
                    
                    Section(header: Text("Related videos")) {
                        ForEach(interestingVideos, id: \.self) { video in
                            SmallWebcastPreviewView(video: video)
                        }
                    }
                }
                .padding(.top, -8)
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle(Text("Launch webcast"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
            .onAppear(perform: {
                self.getThumbnail()
                self.getYouTubeLink()
                self.analyzeYouTubeDescription()
            })
        }
    }
}

struct WebcastSheet_Previews: PreviewProvider {
    static var previews: some View {
        WebcastSheet(videoID: (FakeData.shared.crewDragon?.links?.youtubeID)!, modalShown: .constant(true))
    }
}
