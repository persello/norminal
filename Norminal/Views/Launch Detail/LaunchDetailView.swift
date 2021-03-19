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

struct BottomClipper: Shape {
    let bottom: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Rectangle().path(in: CGRect(x: 0, y: rect.size.height - bottom, width: rect.size.width, height: bottom))
    }
}

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
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.74
                    - (launch.links?.flickr?.originalImages?.first == nil ? 100 : 0))
            .scaledToFit()
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
            .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
            
            // Recap view
            MissionRecapView()
                .shadow(radius: 12)
                .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
                .background(VisualEffectBlur(blurStyle: UIBlurEffect.Style.systemThinMaterial))
                .alignmentGuide(.bottom, computeValue: { dimension in
                    dimension[launch.links?.flickr?.originalImages?.first == nil ? .top : .bottom]
                })
        }
    }
}


struct LaunchDetailResourcesView: View {
    
    @EnvironmentObject var launch: Launch
    @State var isRedditActionSheetPresented: Bool = false
    
    var redditButtons: [ActionSheet.Button] {
        var list: [ActionSheet.Button] = [ActionSheet.Button.cancel()]
        
        if let campaignLink = launch.links?.reddit?.campaign {
            list.append(ActionSheet.Button.default(Text("Campaign")) {
                UIApplication.shared.open(campaignLink)
            })
        }
        
        if let launchLink = launch.links?.reddit?.launch {
            list.append(ActionSheet.Button.default(Text("Launch")) {
                UIApplication.shared.open(launchLink)
            })
        }
        
        if let mediaLink = launch.links?.reddit?.media {
            list.append(ActionSheet.Button.default(Text("Media")) {
                UIApplication.shared.open(mediaLink)
            })
        }
        
        if let recoveryLink = launch.links?.reddit?.recovery {
            list.append(ActionSheet.Button.default(Text("Recovery")) {
                UIApplication.shared.open(recoveryLink)
            })
        }
        
        return list
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Resources")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal, 16)
                .padding(.top, 48)
                .padding(.bottom, -8)
            
            List {
                
                if redditButtons.count > 1 {
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
                        ActionSheet(title: Text("Choose Reddit coverage post"), buttons: redditButtons)
                    })
                }
                
                if let webcast = launch.links?.webcast {
                    Button(action: {
                        UIApplication.shared.open(webcast)
                    }) {
                        HStack {
                            Image("youtube.logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding(.horizontal, 4)
                            
                            Text("YouTube")
                        }
                    }
                }
                
                if let presskit = launch.links?.pressKit {
                    Button(action: {
                        UIApplication.shared.open(presskit)
                    }) {
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
                }
                
                if let wikipedia = launch.links?.wikipedia {
                    Button(action: {
                        UIApplication.shared.open(wikipedia)
                    }) {
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
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct LaunchDetailView: View {
    @State var launch: Launch
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LaunchDetailHeaderView()
                
                // MARK: List of cards
                VStack(alignment: .leading) {
                    
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
                    LaunchDetailResourcesView()
                        .scaledToFit()
                    
                }
                .background(Color(UIColor.systemBackground))
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
        .previewLayout(.fixed(width: 400, height: 3500))
    }
}

struct LaunchDetailResourcesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchDetailResourcesView()
                .environmentObject(FakeData.shared.crewDragon!)
        }
        .previewLayout(.sizeThatFits)
    }
}
