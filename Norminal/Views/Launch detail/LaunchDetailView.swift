//
//  LaunchDetailView.swift
//  Norminal
//
//  Created by Riccardo Persello on 10/10/2020.
//

import SwiftUI
import PageView
import SDWebImageSwiftUI
import VisualEffects

struct LaunchDetailView: View {
    @State var launch: Launch
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                GeometryReader { (geometry: GeometryProxy) in
                    if geometry.frame(in: .global).minY <= 0 {
                        WebImage(url: launch.links?.flickr?.originalImages![0]).resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height)
                    } else {
                        WebImage(url: launch.links?.flickr?.originalImages![0]).resizable()
                            .aspectRatio(contentMode: .fill)
                            .offset(y: -geometry.frame(in: .global).minY)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height
                                    + geometry.frame(in: .global).minY)
                    }
                }.frame(height: UIScreen.main.bounds.height/16*10)
                VStack(alignment: .leading) {
                    MissionRecapCard(launch: launch)
                        .padding(.top, -50)
                        .padding(.horizontal, 24)
                        .shadow(radius:24)
                    
                    Text("Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, -8)
                    
                    if((launch.links?.youtubeID ?? "").count > 0) {
                        WebcastCard(launch: launch)
                    }
                    
                    Spacer(minLength: 120)

                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchDetailView(launch: FakeLaunches.shared.crewDragon!)
        }
    }
}
