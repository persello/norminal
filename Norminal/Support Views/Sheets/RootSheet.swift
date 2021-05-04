//
//  RootSheet.swift
//  Norminal
//
//  Created by Riccardo Persello on 04/05/21.
//

import SwiftUI

struct RootSheet<Content: View>: View {
    @Binding var modalShown: Bool
    var content: () -> Content
    
    init(modalShown: Binding<Bool>, _ content: @escaping () -> Content) {
        self._modalShown = modalShown
        self.content = content
    }

    var body: some View {
        NavigationView {
            content()
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
        RootSheet(modalShown: .constant(true)) { Text("Content").navigationTitle("Title") }
    }
}
