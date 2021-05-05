//
//  PhotoSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 08/12/2020.
//

import SwiftUI
import Telescope

struct PhotoSheet: View {
    @State var imageURL: URL
    
    @State private var isSharing: Bool = false
    @State private var preparingImage: Bool = false
    
    @State private var sharedImage: UIImage?
        
    func prepareImageForSharing() {
        if let data = try? Data(contentsOf: imageURL) {
            if let image = UIImage(data: data) {
                sharedImage = image
                preparingImage = false
                isSharing = true
            }
        }
    }
    
    var body: some View {
        TImage(RemoteImage(imageURL: imageURL))
            .resizable()
            .scaledToFit()
            .navigationBarItems(trailing: Button(action: {
                preparingImage = true
                DispatchQueue.global(qos: .background).async {
                    prepareImageForSharing()
                }
            }) {
                if !preparingImage {
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .font(.body)
                } else {
                    ProgressView()
                }
            })
            .sheet(isPresented: $isSharing, content: {
                ShareSheet(activityItems: [sharedImage!])
            })
            .pinchToZoom()
    }
}

struct PhotoSheet_Previews: PreviewProvider {
    static var previews: some View {
        PhotoSheet(imageURL: (FakeData.shared.crewDragon?.links?.flickr?.originalImages?[0])!)
    }
}
