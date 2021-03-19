//
//  LaunchDetailView.swift
//  Norminal
//
//  Created by Riccardo Persello on 10/10/2020.
//

import SwiftUI
import VisualEffects
import MapKit
import Telescope

struct LaunchDetailView: View {
    @State var launch: Launch
    @State var mapImage: UIImage?
    
    @State var isRedditActionSheetPresented: Bool = false
    
    func getMapSnapshot(geometry: GeometryProxy) {
        let options = MKMapSnapshotter.Options()
        options.scale = UIScreen.main.scale
        options.showsBuildings = true
        options.pointOfInterestFilter = .excludingAll
        
        // Double the resolution for keeping high quality in rubber-banding
        options.size = CGSize(width: geometry.size.width * 2, height: geometry.size.height * 2)
        options.region = MKCoordinateRegion(
            center: (launch.getLaunchpad()?.location)!,
            latitudinalMeters: 4000,
            longitudinalMeters: 4000)
        options.mapType = .satelliteFlyover
        
        let mapSnapshotter = MKMapSnapshotter(options: options)
        mapSnapshotter.start { (snap, _) in
            if let image = snap?.image {
                mapImage = image
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                GeometryReader { (geometry: GeometryProxy) in
                    if geometry.frame(in: .global).minY <= 0 {
                        if let imageURL = launch.links?.flickr?.originalImages?.first {
                            TImage(RemoteImage(imageURL: imageURL))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(y: -0.1 * geometry.frame(in: .global).minY)
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height)
                        } else {
                            if let mpi = mapImage {
                                Image(uiImage: mpi)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(y: -0.1 * geometry.frame(in: .global).minY)
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height)
                            } else {
                                ProgressView()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height)
                                    .onAppear(perform: {
                                        if launch.links?.flickr?.originalImages?.first == nil {
                                            getMapSnapshot(geometry: geometry)
                                        }
                                    })
                            }
                        }
                    } else {
                        if let imageURL = launch.links?.flickr?.originalImages?.first {
                            TImage(RemoteImage(imageURL: imageURL))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .offset(y: -geometry.frame(in: .global).minY)
                                .frame(width: geometry.size.width,
                                       height: geometry.size.height
                                        + geometry.frame(in: .global).minY)
                            
                        } else {
                            if let mpi = mapImage {
                                Image(uiImage: mpi)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(y: -geometry.frame(in: .global).minY)
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height
                                            + geometry.frame(in: .global).minY)
                            } else {
                                ProgressView()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height)
                                    .onAppear(perform: {
                                        if launch.links?.flickr?.originalImages?.first == nil {
                                            getMapSnapshot(geometry: geometry)
                                        }
                                    })
                            }
                        }
                    }
                }.frame(height: UIScreen.main.bounds.height / 16 * 10)
                
                // MARK: List of cards
                VStack(alignment: .leading) {
                    MissionRecapCard(launch: launch)
                        .padding(.top, -50)
                        .padding(.horizontal, 24)
                        .shadow(radius: 24)
                    
                    Text("Details")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                        .padding(.top, 24)
                        .padding(.bottom, -8)
                    
                    // MARK: "Real" cards
                    Group {
                        // Continue to show countdown for 1 hour after launch
                        if Date() < (launch.dateUTC + 3600) {
                            LaunchCountdownView()
                                .shadow(radius: 24)
                                .padding()
                        }
                        
                        if launch.getCrew()?.count ?? 0 > 0            {
                            CrewCard()
                        }
                        
                        // TODO: Show only when really available
                        MissionDetailsCard()
                        
                        PayloadCard()
                        
                        RocketCard()
                        
                        if launch.links?.flickr?.originalImages?.count ?? 0 > 0 {
                            GalleryCard()
                        }
                        
                        if (launch.links?.youtubeID ?? "").count > 0 {
                            WebcastCard()
                        }
                        
                    }
                    
                    // MARK: Footer
                    Text("Resources")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                        .padding(.top, 48)
                        .padding(.bottom, -8)
                    
                    List {
                        Button(action: {
                            isRedditActionSheetPresented = true
                        }) {
                            HStack {
                                Image("reddit.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.horizontal, 4)
                                
                                Text("Reddit")
                            }
                        }
                        .actionSheet(isPresented: $isRedditActionSheetPresented, content: {
                            // TODO: Enumerate across optional links and don't present action sheet if only one is available
                            ActionSheet(title: Text("Choose Reddit coverage post"), buttons: [
                                .cancel(),
                                .default(Text("Campaign")),
                                .default(Text("Launch")),
                                .default(Text("Media")),
                                .default(Text("Recovery"))
                            ])
                        })
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            HStack {
                                Image("youtube.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.horizontal, 4)
                                
                                Text("YouTube")
                            }
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            HStack {
                                Image(systemName: "newspaper.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .foregroundColor(.blue)
                                    .padding(.horizontal, 4)
                                
                                Text("Press Kit")
                            }
                        }
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            HStack {
                                Image("wikipedia.logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .frame(width: 28, height: 28)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                                
                                Text("Wikipedia")
                            }
                        }
                    }
                    .scaledToFit()
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(launch)
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchDetailView(launch: FakeData.shared.nrol108!)
        }
    }
}
