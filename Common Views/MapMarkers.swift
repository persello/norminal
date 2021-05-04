//
//  MapMarkers.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import MapKit
import SwiftUI

struct TextMapMarkerView: View {
    var text: String

    var body: some View {
        CustomMapMarker<Color>(text: text)
    }
}

struct ImageMapMarkerView: View {
    var image: Image
    var scale: CGFloat = 1

    var body: some View {
        CustomMapMarker(
            background: image
                .resizable()
                .scaleEffect(scale)
        )
    }
}

private struct CustomMapMarker<Content: View>: View {
    var text: String?
    var background: Content = Color.background as! Content

    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(Color.ultralightGray, lineWidth: 4)
                .background(
                    background
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.4), radius: 10)
                        .frame(width: 100, height: 100, alignment: .center)
                )
                .frame(width: 100, height: 100, alignment: .center)

            if let t = text {
                Text(t)
                    .font(.system(size: 200))
                    .scaledToFit()
                    .minimumScaleFactor(0.00001)
                    .lineLimit(1)
                    .frame(width: 61.8, height: 61.8, alignment: .center)
            }
        }
    }
}

struct MapMarkers_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ImageMapMarkerView(image: Image("dragon.space"), scale: 2)
            TextMapMarkerView(text: "🚀")
        }
        .padding()
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(.light)
    }
}
