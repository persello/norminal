//
//  WebcastSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 19/11/2020.
//

import SwiftUI
import XCDYouTubeKit
import AVKit
import VideoPlayer
import VisualEffects

struct WebcastSheet: View {
    @Binding var modalShown: Bool
    
    @State private var play: Bool = true
    @State private var time: CMTime = .zero
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VideoPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!, play: $play, time: $time)
                    
                    VStack {
                        VisualEffectBlur(blurStyle: .systemThinMaterialDark, vibrancyStyle: .label) {
                            HStack {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "arrow.up.backward.and.arrow.down.forward")
                                })
                                Spacer()
                                Text("Launch title")
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "gear")
                                })
                            }
                            .padding(4)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        .foregroundColor(.white)
                        .frame(height: 30)
                        .padding(6)

                        
                        Spacer()
                        VisualEffectBlur(blurStyle: .systemThinMaterialDark, vibrancyStyle: .label) {
                            HStack {
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "play.fill")
                                })
                                Slider(value: .constant(0.6))
                                
                            }
                            .padding(4)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                        .foregroundColor(.white)
                        .frame(height: 30)
                        .padding(6)
                    }
                }
                .aspectRatio(1.78, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .padding()
                Spacer()
            }
            .navigationBarTitle(Text("Launch webcast"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct WebcastSheet_Previews: PreviewProvider {
    static var previews: some View {
        WebcastSheet(modalShown: .constant(true))
    }
}
