//
//  CapsuleListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI
import Telescope

struct CapsuleListTile: View {
    var capsule: Capsule
    
    @State var launches: [Launch] = []
    @State var dragonModel: Dragon?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    let status = capsule.status
                    
                    Text(capsule.serial)
                        .bold()
                        .foregroundColor((status == .active || status == .unknown) ? .primary : .gray)
                    
                    if status != .unknown {
                        Text(status.rawValue.capitalizingFirstLetter())
                            .foregroundColor(status == .retired ? .yellow : status == .destroyed ? .red : .lightGray)
                            .bold()
                    }
                }
                
                if let model = dragonModel?.name {
                    Text(model)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            ForEach(launches) {launch in
                TImage(launch.getPatch())
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
            }
        }
        .onAppear {
            capsule.getLaunches { launches in
                self.launches = launches ?? []
            }
            
            capsule.getDragonModel { model in
                self.dragonModel = model
            }
        }
    }
}

struct CapsuleListTile_Previews: PreviewProvider {
    static var previews: some View {
        CapsuleListTile(capsule: FakeData.shared.c207!)
            .previewLayout(.sizeThatFits)
    }
}
