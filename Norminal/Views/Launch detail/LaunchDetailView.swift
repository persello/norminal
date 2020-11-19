//
//  LaunchDetailView.swift
//  Norminal
//
//  Created by Riccardo Persello on 10/10/2020.
//

import SwiftUI
import SDWebImageSwiftUI
import VisualEffects
import MapKit

struct LaunchDetailView: View {
    @State var launch: Launch
    @State var mapImage: UIImage?
    
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
        Color(UIColor.systemGray6)
            .ignoresSafeArea(edges: .all)
            .overlay(
                ScrollView(.vertical) {
                    VStack {
                        GeometryReader { (geometry: GeometryProxy) in
                            if geometry.frame(in: .global).minY <= 0 {
                                if let imageURL = launch.links?.flickr?.originalImages?.first {
                                    WebImage(url: imageURL).resizable()
                                        .indicator(Indicator.activity(style: .large))
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
                                    WebImage(url: imageURL).resizable()
                                        .indicator(Indicator.activity(style: .large))
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
                            
                            if (launch.links?.youtubeID ?? "").count > 0 {
                                WebcastCard(launch: launch)
                            }
                            
                            if let crew = launch.getCrew() {
                                CrewCard(crew: crew)
                            }
                            
                            Spacer(minLength: 120)
                            
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            )
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchDetailView(launch: FakeData.shared.crewDragon!)
        }
    }
}
