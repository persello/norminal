//
//  GallerySheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 07/12/2020.
//

import SwiftUI
import Telescope

struct GallerySheet: View {
    @Binding var modalShown: Bool
    var launch: Launch
    
    private let cols = [GridItem(.adaptive(minimum: 100, maximum: 200), spacing: 2)]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: cols, alignment: .center, spacing: 2) {
                        ForEach((launch.links?.flickr?.originalImages)!, id: \.absoluteString) { imageURL in
                            GeometryReader { gr in
                                NavigationLink(destination: PhotoSheet(imageURL: imageURL)) {
                                    TImage(RemoteImage(imageURL: imageURL))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: gr.size.width)
                                }
                            }
                            .clipped()
                            .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
            .navigationTitle("Photo gallery")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct GallerySheet_Previews: PreviewProvider {
    static var previews: some View {
        GallerySheet(modalShown: .constant(true), launch: FakeData.shared.crewDragon!)
    }
}
