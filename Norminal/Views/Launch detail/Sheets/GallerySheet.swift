//
//  GallerySheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 07/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

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

struct GallerySheet: View {
    @Binding var modalShown: Bool
    var launch: Launch
    
    @State var isSharing: Bool = false
        
    private let threeColumnGrid = Array(repeating: GridItem(.flexible(minimum: 60, maximum: 160), spacing: 2), count: 3)
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: threeColumnGrid, alignment: .center, spacing: 2) {
                        ForEach((launch.links?.flickr?.originalImages)!, id: \.absoluteString) { imageURL in
                            GeometryReader { gr in
                                NavigationLink(
                                    destination:                                 WebImage(url: imageURL)
                                        .resizable()
                                        .scaledToFit()
                                        .navigationBarItems(trailing: Button(action: {
                                            self.isSharing.toggle()
                                        }) {
                                            Image(systemName: "square.and.arrow.up")
                                        })
                                        .sheet(isPresented: $isSharing, content: {
                                            ShareSheet(activityItems: [imageURL])
                                        })
                                ) {
                                    WebImage(url: imageURL)
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
            .navigationBarTitle(Text("Photo gallery"), displayMode: .inline)
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
