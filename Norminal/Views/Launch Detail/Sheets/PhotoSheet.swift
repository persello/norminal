//
//  PhotoSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 08/12/2020.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}

struct PhotoSheet: View {
    @State var imageURL: URL

    @State private var isSharing: Bool = false
    @State private var preparingImage: Bool = false

    @State private var sharedImage: UIImage?

    func prepareImageForSharing() {
        preparingImage = true
      if let data = try? Data(contentsOf: imageURL) {
        if let image = UIImage(data: data) {
          sharedImage = image
          preparingImage = false
          isSharing = true
        }
      }
    }

    var body: some View {
      WebImage(url: imageURL)
            .resizable()
            .scaledToFit()
            .navigationBarItems(trailing: Button(action: {
                prepareImageForSharing()
            }) {
                if !isSharing && !preparingImage {
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
