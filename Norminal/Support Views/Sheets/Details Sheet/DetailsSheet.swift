//
//  DetailsSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 03/05/21.
//

import SwiftUI

struct DetailsSheet: View {
    var launch: Launch

    var body: some View {
        List {
            LaunchDetailsSection()
            LaunchMapSection()
        }
        .environmentObject(launch)
//        .listStyle(InsetGroupedListStyle())
        .navigationTitle(Text(launch.name))
    }
}

struct DetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailsSheet(launch: FakeData.shared.nrol108!)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
