//
//  GalleryCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 07/12/2020.
//

import SwiftUI
import Telescope

struct GalleryCard: View {
    @EnvironmentObject var launch: Launch
    @State var modalPresented: Bool = false

    private let threeColumnGrid = Array(repeating: GridItem(.flexible(minimum: 60, maximum: 160), spacing: 2), count: 3)

    var body: some View {
        Card(background: {
            let numberOfPictures = launch.links?.flickr?.originalImages?.count ?? 0
            if numberOfPictures > 3 {
                LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 2) {
                    // Using index for filling at least 9 images
                    
                    ForEach(0..<9) { index in
                        GeometryReader { gr in
                            TImage(RemoteImage(imageURL: (launch.links?.flickr?.originalImages![index % numberOfPictures])!))
                                .resizable()
                                .frame(width: gr.size.width, height: gr.size.width)
                        }
                    }
                    .clipped()
                    .aspectRatio(1, contentMode: .fill)
                    
                }
            } else if (1...3).contains(numberOfPictures) {
                TImage(RemoteImage(imageURL: (launch.links?.flickr?.originalImages![0])!))
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(1.5)
            }
            
        }, content: {
            CardOverlay(preamble: "Great shots from this mission", title: "Photo gallery", bottomText: "See more", buttonText: "Open", buttonAction: {
                self.modalPresented = true
            })
        })
        .padding()
        .sheet(isPresented: $modalPresented, content: {
            GallerySheet(modalShown: self.$modalPresented, launch: launch)
        })
        
    }
}

struct GalleryCard_Previews: PreviewProvider {
    static var previews: some View {
      GalleryCard()
        .previewLayout(.sizeThatFits)
        .environmentObject(FakeData.shared.nrol108!)
    }
}
