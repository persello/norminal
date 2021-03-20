//
//  LaunchDetailHeaderView.swift
//  Norminal
//
//  Created by Riccardo Persello on 20/03/21.
//

import MapKit
import SwiftUI
import Telescope
import VisualEffects

struct LaunchDetailHeaderView: View {
    
    @EnvironmentObject var launch: Launch
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
        ZStack(alignment: .bottom) {
            GeometryReader { (geometry: GeometryProxy) in
                if geometry.frame(in: .global).minY <= 0 {
                    if let imageURL = launch.links?.flickr?.originalImages?.first {
                        TImage(RemoteImage(imageURL: imageURL))
                            .resizable()
                            .scaledToFill()
                            .offset(y: -geometry.frame(in: .global).minY * 0.5)
                            .frame(width: geometry.size.width)
                    } else {
                        if let mpi = mapImage {
                            Image(uiImage: mpi)
                                .resizable()
                                .scaledToFill()
                                .offset(y: -geometry.frame(in: .global).minY * 0.5)
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
                            .scaledToFill()
                            .offset(y: -geometry.frame(in: .global).minY)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height
                                    + geometry.frame(in: .global).minY)
                        
                    } else {
                        if let mpi = mapImage {
                            Image(uiImage: mpi)
                                .resizable()
                                .scaledToFill()
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
            }
            .scaledToFill()
            .frame(height: UIScreen.main.bounds.height * 0.74
                    - (launch.links?.flickr?.originalImages?.first == nil ? 100 : 0))
            .clipShape(BottomClipper(bottom: UIScreen.main.bounds.height * 2))
            
            // Shadow on top
            GeometryReader { geometry in
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [
                                                            Color(UIColor.black.withAlphaComponent(0.45)),
                                                            .clear]),
                                       startPoint: .top,
                                       endPoint: .bottom))
                    .offset(y: -geometry.frame(in: .global).minY)
            }
            .frame(height: 200, alignment: .center)
            
            // Recap view
            MissionRecapView()
                .shadow(radius: 12)
                .frame(height: 100, alignment: .center)
                .background(VisualEffectBlur(blurStyle: UIBlurEffect.Style.systemThinMaterial))
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[launch.links?.flickr?.originalImages?.first == nil ? .top : .bottom]
                })
        }
    }
}

struct LaunchDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailHeaderView()
            .environmentObject(FakeData.shared.nrol108!)
            .previewLayout(.sizeThatFits)
    }
}
