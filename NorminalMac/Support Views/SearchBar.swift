//
//  SearchBar.swift
//  Norminal for Mac
//
//  Created by Riccardo Persello on 28/03/21.
//

import Foundation
import Cocoa
import SwiftUI

struct SearchField: NSViewRepresentable {

    class Coordinator: NSObject, NSSearchFieldDelegate {
        var parent: SearchField

        func controlTextDidEndEditing(_ obj: Notification) {
            if parent.focusChangedCallback != nil {
                parent.focusChangedCallback!(false)
            }
        }
        
        func controlTextDidBeginEditing(_ obj: Notification) {
            if parent.focusChangedCallback != nil {
                parent.focusChangedCallback!(true)
            }
        }
        
        init(_ parent: SearchField) {
            self.parent = parent
        }

        func controlTextDidChange(_ notification: Notification) {
            guard let searchField = notification.object as? NSSearchField else {
                print("Unexpected control in update notification")
                return
            }
            self.parent.search = searchField.stringValue
        }

    }

    @Binding var search: String
    var focusChangedCallback: ((_ isInFocus: Bool) -> Void)?
    
    func onFocusChange(_ callback: @escaping (Bool) -> Void) -> SearchField {
        var new = self
        new.focusChangedCallback = callback
        return new
    }
    
    func makeNSView(context: Context) -> NSSearchField {
        NSSearchField(frame: .zero)
    }

    func updateNSView(_ searchField: NSSearchField, context: Context) {
        searchField.stringValue = search
        searchField.delegate = context.coordinator
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

struct SearchBar: View {
    @Binding var search: String
    @State var expanded: Bool = false
    
    var body: some View {
            if expanded {
                SearchField(search: $search)
                    .onFocusChange { focus in
                        if focus == false {
                            expanded = false
                        }
                    }
                    .frame(minWidth: 200, maxWidth: .infinity)
            } else {
                Button(action: {expanded = true}, label: {
                    Image(systemName: "magnifyingglass")
                })
            }
    }
}
