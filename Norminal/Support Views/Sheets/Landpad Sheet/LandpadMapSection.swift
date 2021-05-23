//
//  LandpadMapSection.swift
//  Norminal
//
//  Created by Riccardo Persello on 18/05/21.
//

import SwiftUI
import MapKit

struct LandpadMapSection: View {
    @EnvironmentObject var landpad: Landpad
    
    @State var region: MKCoordinateRegion?
    
    var body: some View {
        Section(header: Text("Map")) {
            VStack(alignment: .leading) {
                if region != nil {
                    Map(coordinateRegion: Binding($region)!, annotationItems: [landpad]) { item in
                        MapPin(coordinate: item.location)
                    }
                    .padding(.init(top: -20, leading: -20, bottom: -10, trailing: -20))
                    .aspectRatio(0.618 * 2, contentMode: .fill)
                }
                
                VStack(alignment: .leading) {
                    Text(landpad.locality)
                        .font(.title.bold())
                    Text(landpad.region)
                        .foregroundColor(.gray)
                }
                .padding(.init(top: 15, leading: 5, bottom: 15, trailing: 0))
                .onAppear {
                    region = MKCoordinateRegion(center: landpad.location, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
            }
        }
    }
}

struct LandpadMapSection_Previews: PreviewProvider {
    static var previews: some View {
        List {
            LandpadMapSection()
        }
        .listStyle(InsetGroupedListStyle())
        .environmentObject(FakeData.shared.lz1!)
        .previewLayout(.sizeThatFits)
    }
}
