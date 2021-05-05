//
//  PointOfInterestRow.swift
//  Norminal
//
//  Created by Riccardo Persello on 05/05/21.
//

import SwiftUI
import MapKit

struct PointOfInterestRow: View {
    var poi: PointOfInterest
    @Binding var region: MKCoordinateRegion?
    
    var body: some View {
        HStack {
            poi.getMarker(shadowRadius: 0).scaleEffect(0.5)
                .padding(-20)
                .padding(.leading, -10)
            
            VStack(alignment: .leading) {
                Text(poi.name ?? "Unknown")
                Text(poi.getRolesString() ?? poi.kind.rawValue.capitalizingFirstLetter())
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                
                if (poi.kind == .droneship || poi.kind == .ship)
                    && poi.coordinates != nil {
                    Text("Last known location shown")
                        .font(.subheadline)
                        .foregroundColor(.lightGray)
                }
            }
            
            Spacer()
            
            if let coords = poi.coordinates {
                Button(action: {
                    withAnimation {
                        self.region = MKCoordinateRegion(center: coords, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                    }
                }, label: {
                    Text("\(Image(systemName: "location.circle"))")
                })
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.blue)
            } else {
                Image(systemName: "location.slash")
            }
        }
    }
}

struct PointOfInterestRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 10) {
            PointOfInterestRow(poi: PointOfInterest(
                                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                kind: .launchpad),
                               region: .constant(MKCoordinateRegion()))
            PointOfInterestRow(poi: PointOfInterest(
                                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                kind: .droneship),
                               region: .constant(MKCoordinateRegion()))
            PointOfInterestRow(poi: PointOfInterest(
                                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                kind: .landpad),
                               region: .constant(MKCoordinateRegion()))
            PointOfInterestRow(poi: PointOfInterest(
                                coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                                kind: .ship),
                               region: .constant(MKCoordinateRegion()))
        }
        .padding(20)
        .previewLayout(.sizeThatFits)
    }
}
