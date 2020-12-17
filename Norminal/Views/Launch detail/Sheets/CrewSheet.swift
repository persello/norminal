//
//  CrewSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 16/11/2020.
//

import SwiftUI

struct CrewSheet: View {
    
    var crew: [Astronaut]
    
    @Binding var modalShown: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(crew) { astronaut in
                        
                        NavigationLink(destination: AstronautSheet(astronaut: astronaut)) {
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
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text("Mission crew"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.modalShown.toggle()
            }) {
                Text("Done").bold()
            })
        }
        
    }
}

struct CrewSheet_Previews: PreviewProvider {
    static var previews: some View {
        CrewSheet(crew: [FakeData.shared.robertBehnken!], modalShown: Binding.constant(true))
    }
}