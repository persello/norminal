//
//  LaunchFilterSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 01/05/21.
//

import SwiftUI

struct PickerList: View {
    @ObservedObject private var globalSettings = GlobalSettings.shared

    var body: some View {
        List {
            Picker(selection: globalSettings.$launchFilterSelection,
                   label: Text("Filter")) {
                ForEach(GlobalSettings.Filters.allCases, id: \.hashValue) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }

            Picker(selection: globalSettings.$launchOrderSelection,
                   label: Text("Order")) {
                ForEach(GlobalSettings.Orderings.allCases, id: \.hashValue) { order in
                    Text(order.rawValue).tag(order)
                }
            }
        }
    }
}

struct LaunchFilterSheet<Style: PickerStyle>: View {
    @Binding var modalShown: Bool
    var style: Style

    var body: some View {
        NavigationView {
            PickerList()
                .pickerStyle(style)
                .navigationTitle(Text("Launch filters"))
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    self.modalShown.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}

struct LaunchFilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        Text("Anchor")
            .popover(isPresented: .constant(true), content: {
                LaunchFilterSheet(modalShown: .constant(true), style: DefaultPickerStyle())
                    .frame(minWidth: 300, minHeight: 250, alignment: .center)
            })
            .previewLayout(.sizeThatFits)
        
        Text("Anchor")
            .popover(isPresented: .constant(true), content: {
                LaunchFilterSheet(modalShown: .constant(true), style: SegmentedPickerStyle())
                    .frame(minWidth: 300, minHeight: 250, alignment: .center)
            })
            .previewLayout(.sizeThatFits)
    }
}
