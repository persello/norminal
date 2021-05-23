//
//  AstronautListTile.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct AstronautListTile: View {
    var astronaut: Astronaut
    var body: some View {
        HStack {
            AstronautPicture(astronaut: astronaut)
                .frame(width: 70, height: 70)
                .padding(.vertical, 8)
                .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(astronaut.name).bold()
                Text(astronaut.agency)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct AstronautListTile_Previews: PreviewProvider {
    static var previews: some View {
        AstronautListTile(astronaut: FakeData.shared.robertBehnken!)
    }
}
