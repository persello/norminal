//
//  CoreListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct CoreListView: View {
    var cores: [Core]

    var body: some View {
        Group {
            if cores.count > 0 {
                List {
                    ForEach(cores) { core in
                        NavigationLink(destination: CoreSheet(core: core)) {
                            CoreListTile(core: core)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "flame")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No cores available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Rocket cores"))
    }
}

struct CoreListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoreListView(cores: [FakeData.shared.b1051!, FakeData.shared.b1051!])
        }
    }
}
