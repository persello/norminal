//
//  RootSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import SwiftUI

struct RootSheet<Content: View>: View {
    var content: Content
    @Binding var modalShown: Bool

    var body: some View {
        NavigationView {
            content
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {
                    self.modalShown.toggle()
                }) {
                    Text("Done").bold()
                })
        }
    }
}

struct RootSheet_Previews: PreviewProvider {
    static var previews: some View {
        RootSheet(content: Text("Content").navigationTitle("Title"), modalShown: .constant(true))
    }
}
