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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // Redraw on orientation change
    @State var orientation = UIDevice.current.orientation
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 300), spacing: 0)
    ]
    
    struct CardDescriptor: Identifiable {
        internal init<Content: View>(@ViewBuilder cardBuilder: () -> Content, saliency: Double) {
            self.card = AnyView(cardBuilder())
            self.saliency = saliency
        }
        
        let id = UUID()
        let card: AnyView
        let saliency: Double
    }
    
    func cardsBuilder() -> [CardDescriptor] {
        var cardList: [CardDescriptor] = []
        
        // Generate and reorder cards
        
        // Launch countdown (not a "real" card)
        // Continue to show countdown for 1 hour after launch
        if Date() < (launch.dateUTC + 3600) {
            // Always maximum saliency
            cardList.append(CardDescriptor(cardBuilder: {
                LaunchCountdownView()
                    .shadow(radius: 24)
                    .padding()
            }, saliency: 1000))
        }
        
        if launch.getCrew()?.count ?? 0 > 0 {
            cardList.append(CardDescriptor(cardBuilder: {
                CrewCard()
            }, saliency: 900))
        }
        
        // TODO: Implement
        if true {
            cardList.append(CardDescriptor(cardBuilder: {
                MissionDetailsCard()
            }, saliency: 800))
        }
        
        if launch.payloads?.count ?? 0 > 0 {
            cardList.append(CardDescriptor(cardBuilder: {
                PayloadCard()
            }, saliency: 700))
        }
        
        if launch.rocket != nil {
            cardList.append(CardDescriptor(cardBuilder: {
                RocketCard()
            }, saliency: 600))
        }
        
        // TODO: Variable saliency
        if (launch.links?.youtubeID ?? "").count > 0 {
            cardList.append(CardDescriptor(cardBuilder: {
                WebcastCard()
            }, saliency: 500))
        }
        
        if launch.links?.flickr?.originalImages?.count ?? 0 > 0 {
            cardList.append(CardDescriptor(cardBuilder: {
                GalleryCard()
            }, saliency: 400))
        }
    
        cardList.append(CardDescriptor(cardBuilder: {
            LaunchDetailResourcesView().scaledToFill()
                .zIndex(-1)
                .padding(horizontalSizeClass == .regular ? 8 : 0)
        }, saliency: 0))
        
        return cardList.sorted { a, b in
            a.saliency > b.saliency
        }
    }
    
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
                    LazyVGrid(columns: columns) {
                        let cards = cardsBuilder()
                        ForEach(cards) { card in
                            card.card
                        }
                    }
                    
                }
                .background(Color(UIColor.systemBackground))
                .padding(horizontalSizeClass == .regular ? 24 : 8)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(launch)
        .onReceive(orientationChanged) { _ in
            self.orientation = UIDevice.current.orientation
        }
    }
}

struct LaunchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LaunchDetailView(launch: FakeData.shared.nrol108!)
                .previewDevice("iPad Air (4th generation)")
        }
    }
}
