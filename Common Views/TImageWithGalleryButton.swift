//
//  TImageWithGalleryButton.swift
//  Norminal
//
//  Created by Riccardo Persello on 21/05/21.
//

import SwiftUI
import Telescope

struct TImageWithGalleryButton: View {
    var imageURLs: [URL]
    @State var galleryModalPresented: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let imageURL = imageURLs.first {
                TImage(RemoteImage(imageURL: imageURL))
                    .resizable()
                    .scaledToFill()
                    .padding(.vertical, -6)

                Button(action: { galleryModalPresented.toggle() }, label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .foregroundColor(.white)
                })
                    .frame(width: 40, height: 40, alignment: .leading)
                    .shadow(radius: 4)
                    // For limiting tappable area in lists
                    .buttonStyle(BorderlessButtonStyle())
                    .sheet(isPresented: $galleryModalPresented, content: {
                        RootSheet(modalShown: $galleryModalPresented) { GallerySheet(imageURLs: imageURLs) }
                    })
            }
        }
    }
}

struct TImageWithGalleryButton_Previews: PreviewProvider {
    static var previews: some View {
        TImageWithGalleryButton(imageURLs: (FakeData.shared.falcon9?.flickrImages)!)
            .scaledToFit()
    }
}
