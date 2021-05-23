//
//  CapsuleListView.swift
//  Norminal
//
//  Created by Riccardo Persello on 23/05/21.
//

import SwiftUI

struct CapsuleListView: View {
    struct CapsuleView: View {
        var capsule: Capsule
        var body: some View {
            List {
                PayloadCapsuleInstanceSections(capsule: capsule)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Capsule"))
        }
    }

    var capsules: [Capsule]

    var body: some View {
        Group {
            if capsules.count > 0 {
                List {
                    ForEach(capsules) { capsule in
                        NavigationLink(destination: CapsuleView(capsule: capsule)) {
                            CapsuleListTile(capsule: capsule)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            } else {
                VStack {
                    Image(systemName: "questionmark")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(.lightGray)
                        .padding()

                    Text("No capsules available")
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(Text("Capsules"))
    }
}

struct CapsuleListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CapsuleListView(capsules: [FakeData.shared.c207!, FakeData.shared.c207!])
        }
    }
}
