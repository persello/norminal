//
//  GalleryCard.swift
//  Norminal
//
//  Created by Riccardo Persello on 07/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct GalleryCard: View {
    @State var launch: Launch
    @State var modalPresented: Bool = false

    private let threeColumnGrid = Array(repeating: GridItem(.flexible(minimum: 60, maximum: 160), spacing: 2), count: 3)

    var body: some View {
        Card(background: {
            ZStack(alignment: .top) {
                Color(UIColor.systemGray5)

                LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 2) {
                    // Using index for filling at least 9 images
                    ForEach(0..<12) { index in
                        GeometryReader { gr in
                            let numberOfPictures = launch.links?.flickr?.originalImages?.count ?? 0
                            if numberOfPictures > 0 {
                              WebImage(url: launch.links?.flickr?.originalImages![index % numberOfPictures])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: gr.size.width)
                            }
                        }
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                    }
                }

                Rectangle()
                    .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.7), .clear]),
                            startPoint: .top,
                            endPoint: .bottom))
                    .frame(width: 1200, height: 240)
                    .clipped()
            }
            .drawingGroup()

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
      GalleryCard(launch: FakeData.shared.crewDragon!)
        .previewLayout(.sizeThatFits)
    }
}
