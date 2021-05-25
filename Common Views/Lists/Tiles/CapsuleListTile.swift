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
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(capsule.serial)
                        .bold()
                        .foregroundColor((capsule.status == .active || capsule.status == .unknown) ? .primary : .gray)
                    
                    let status = capsule.status
                    if status != .unknown {
                        Text(status.rawValue.capitalizingFirstLetter())
                            .foregroundColor(status == .retired ? .yellow : status == .destroyed ? .red : .lightGray)
                            .bold()
                    }
                }
                
                if let model = capsule.dragonModel?.name {
                    Text(model)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            ForEach(capsule.launches) {launch in
                TImage(launch.getPatch())
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .center)
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
