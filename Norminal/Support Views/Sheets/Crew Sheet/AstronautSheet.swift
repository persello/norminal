//
//  AstronautSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/11/2020.
//

import SwiftUI

struct AstronautSheet: View {
    @State var astronaut: Astronaut

    var body: some View {
        Color(.systemGray6)
            .ignoresSafeArea(edges: .all)
            .overlay(
                List {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            AstronautPicture(astronaut: astronaut)
                                .frame(width: 160, height: 160)
                                .padding(.top, 48)
                                .padding(.bottom, 12)
                                .colorfulShadow(radius: 12, saturation: 2)
                                .shadow(radius: 12)
                            Text(astronaut.name)
                                .font(.largeTitle)
                            HStack {
                                Text(astronaut.agency)
                                Circle()
                                    .frame(width: 6, height: 6)
                                    .padding(.vertical, -4)
                                Text(astronaut.status.capitalized)
                            }
                            .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                        }
                        .padding(.bottom, 16)
                        Spacer()
                    }

                    if let wikipedia = astronaut.wikipedia {
                        Link(destination: wikipedia, label: {
                            Label("Read more on Wikipedia", systemImage: "safari.fill")
                        })
                    }

                    if let launches = astronaut.getLaunches(),
                       launches.count > 0 {
                        Section(header: Text("\(launches.count) launches")) {
                            ForEach(launches) { launch in
                                LaunchListTile(launch: launch)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            )
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautSheet_Previews: PreviewProvider {
    static var previews: some View {
        AstronautSheet(astronaut: FakeData.shared.robertBehnken!)
    }
}
