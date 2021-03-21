//
//  WebcastSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/11/2020.
//

import SwiftUI
import XCDYouTubeKit
import AVKit
import Telescope

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

struct SmallWebcastPreviewView: View {
    var video: XCDYouTubeVideo
    
    var body: some View {
        HStack {
            TImage(try? RemoteImage(stringURL: (video.thumbnailURLs?.first?.absoluteString ?? "")))
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
    
    @State var video: XCDYouTubeVideo?
    @State var errorString: String?
    
    var body: some View {
        if let v = video {
            NavigationView {
                WebcastSheetInnerView(modalShown: $modalShown, video: v)
            }
        } else {
            if let e = errorString {
                Text(e)
            } else {
                ProgressView()
                    .onAppear {
                        XCDYouTubeClient.default().getVideoWithIdentifier(videoID) { (video, error) in
                            self.video = video
                        }
                    }
            }
        }
    }
}

struct WebcastSheetInnerView: View {
    
    // Parameters
    @Binding var modalShown: Bool
    
    // Player
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    
    // Video
    var video: XCDYouTubeVideo
    @State private var player: AVPlayer?
    @State private var interestingVideos: [XCDYouTubeVideo] = []
    
    func analyzeYouTubeDescription(video: XCDYouTubeVideo) {
        
        if let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) {
            
            let matches = detector.matches(in: video.videoDescription, options: [], range: NSMakeRange(0, video.videoDescription.utf16.count))
            
            let strings = matches.compactMap({$0.url?.description})
            let ids = strings.compactMap({$0.split(separator: "/").last?.description})
            
            for id in ids {
                XCDYouTubeClient.default().getVideoWithIdentifier(id) { (video, _)  in
                    guard video != nil else {
                        return
                    }
                    
                    // Add this video
                    if !interestingVideos.contains(video!) {
                        interestingVideos.append(video!)
                    }
                    
                    // TODO: Recurse only once?
                }
            }
        }
    }
    
    func getYouTubeLink(video: XCDYouTubeVideo) {
        
        //Do something with video
        let link = video.streamURLs[YouTubeVideoQuality.medium360]
        if let link = link {
            player = AVPlayer(url: link)
            player?.automaticallyWaitsToMinimizeStalling = true
            player?.allowsExternalPlayback = true
            
            // Override silent switch
            // swiftlint:disable force_try
            try! AVAudioSession.sharedInstance().setCategory(.playback)
            
            // Push video title to "Now playing" info
            var videoInfo = [String: Any]()
            videoInfo[MPMediaItemPropertyTitle] = video.title
            
            MPNowPlayingInfoCenter.default().nowPlayingInfo = videoInfo
        }
    }
    
    var body: some View {
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
                    // Gray rectangle
                    Rectangle()
                        .fill(Color(UIColor.systemGray5))
                        .aspectRatio(16/9, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                    
                    ProgressView()
                }
            }
            
            List {
                if let YouTubeURL = URL(string: "https://www.youtube.com/watch?v=\(video.identifier)") {
                    Section {
                        Link(destination: YouTubeURL, label: {
                            Label("Watch on YouTube", systemImage: "play.rectangle.fill")
                        })
                    }
                }
                
                if interestingVideos.count > 0 {
                    Section(header: Text("Related videos")) {
                        ForEach(interestingVideos, id: \.self) { video in
                            NavigationLink(destination: WebcastSheetInnerView(modalShown: $modalShown, video: video)) {
                                SmallWebcastPreviewView(video: video)
                            }
                        }
                    }
                }
            }
            .padding(.top, -8)
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(video.title)
        .navigationBarItems(trailing: Button(action: {
            self.modalShown.toggle()
        }) {
            Text("Done").bold()
        })
        .onAppear(perform: {
            // Do operations on video
            self.getYouTubeLink(video: video)
            self.analyzeYouTubeDescription(video: video)
        })
    }
}

struct WebcastSheet_Previews: PreviewProvider {
    static var previews: some View {
        WebcastSheet(videoID: (FakeData.shared.crewDragon?.links?.youtubeID)!, modalShown: .constant(true))
    }
}
